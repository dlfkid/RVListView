#!/bin/sh

echo "Input option num: $#, detail: $1:$*"
if [[ $# == 0 ]]; then
    echo "input option is invalid, please input tag with format then excute again, eg: sh tag_publish.sh 1.0.0"
    exit 1
fi

FRAMEWORK_NAME=$1
TAG_NAME=$2
TAG_FORMATTED="$TAG_NAME"
TAG_REGEX=^[0-9]+\.[0-9]+\.[0-9a-z]+$
echo "TAG_NAME: $TAG_NAME"

if [[ "$TAG_NAME" =~ $TAG_REGEX ]]; then
    echo "tag format is valid, proceed to publish sequence"
else
    echo "tag format is invalid, please input a correct tag and try again"
    exit 1
fi

BRANCH_NAME=$3
if [[ $BRANCH_NAME > 0 ]]; then
    echo "specific branch is detected, switching to branch $BRANCH_NAME"
    git checkout $BRANCH_NAME
    git pull
fi

RELEASE_SRCSPEC=./${FRAMEWORK_NAME}.podspec
GIT_DIR=.
echo "Update podspec version"
sed -i "" "s/=[[:space:]]*[\"\'][0-9]*\.[0-9]*\.[0-9a-z]*[\"\']/= \'$TAG_NAME\'/g" $RELEASE_SRCSPEC

cd $GIT_DIR
echo "generating commit"
TAG_REF="refs/tags/$TAG_FORMATTED"

# Getting git info
CUR_REV=$(git rev-parse HEAD)
CUR_BRANCH=$(git rev-parse --abbrev-ref HEAD)
# Generating branch name
PUBLISH_BRANCH="auto_tag_publish/$TAG_FORMATTED"

prepare() {
    echo ">>>> PREPARE FOR PUBLISH $TAG_FORMATTED"
    git fetch --prune
}

pushTag() {
    echo ">>>> PUSH TAGS $TAG_FORMATTED"
    git tag -a $TAG_FORMATTED -m "tag $TAG_FORMATTED"
    git push -q origin $TAG_FORMATTED
}

deleteTag() {
    echo ">>>> DELETE TAGS $TAG_FORMATTED"
    git push -q --delete origin $TAG_FORMATTED
    git tag -d $TAG_FORMATTED
}

pushSpecCommit() {
    echo ">>>> PUSH SPEC MODIFICATIONS"
    git checkout -b $PUBLISH_BRANCH
    git add -u
    git commit -am "chore: [Release version] $TAG_FORMATTED"
    git push -q -u origin $PUBLISH_BRANCH
}

mergeBack() {
    echo ">>>> BEGIN MERGE BACK TO PREVIOUS BRANCH: $CUR_BRANCH"
    git checkout $CUR_BRANCH
    git merge $PUBLISH_BRANCH
    git push -q
}

resetBack() {
    echo ">>>> BEGIN RESET TO PREVIOUS COMMIT"
    git reset --mixed $CUR_REV
    git checkout $CUR_BRANCH
}

cleanUp() {
    echo ">>>> BEGIN CLEAN UP GIT REPO"
    echo $(git rev-parse --abbrev-ref HEAD)
    git push --delete origin $PUBLISH_BRANCH
    git branch -d -f $PUBLISH_BRANCH
}

printPodErrorOutput() {
    if [[ "$1" == *"- ERROR"* ]]; then
        echo ">>>> POD PUBLISH ERROR OUTPUT:"
        echo "$1" | grep -e "- ERROR"
        return 1
    else
        return 0
    fi
}

handleBackUpBranch() {
    printPodErrorOutput "$1"
    if [[ $? -ne 0 ]]; then
        deleteTag
        echo ">>>> Pod repo push failed, please confirm that user has the correct authority"
        resetBack
    else
        mergeBack
    fi

    cleanUp
}

prepare

if [[ $(git ls-remote -q -t --exit-code origin $TAG_REF) != "" ]]; then
    echo "Tag already exist，no need to update"
    echo "Delete remote tag then try again if necessary."
    exit 0
else
    if [ "${TKP_DISABLE_LINT}" != "1" ]
    then
        LINT_RET=$(pod lib lint --allow-warnings --use-libraries --verbose $RELEASE_SRCSPEC)
        printPodErrorOutput "$LINT_RET"
        if [[ $? -ne 0 ]]; then
            # deleteTag
            echo "pod lib lint failed, check podspec again"
            exit 1
        fi
    fi

    GIT_CREDENTIAL_MANAGER_VERSION=$(git-credential-manager --version)

    if [ GIT_CREDENTIAL_MANAGER_VERSION == 0 ]
    then
        echo "Git credential manager not installed, see https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories"
        exit 1
    fi
    
    echo "Using git credential manager $GIT_CREDENTIAL_MANAGER_VERSION"

    pushSpecCommit
    # deleteTag
    pushTag
    if [ $? -ne 0 ]; then
        echo ">>>> script runs failed with error"
        exit 1
    fi
    echo ">>>> pod cache clean"
    pod cache clean --all

    CUSTOM_SOURCE_URL=$4
    if [ $CUSTOM_SOURCE_URL > 0 ]; then
        echo "custom source is detected, use custom source as publish target instead."
        echo ">>>> pod repo add"
        pod repo add tag_publish_source $CUSTOM_SOURCE_URL
        echo ">>>> pod repo push"
        PUSH_RET=$(COCOAPODS_VALIDATOR_SKIP_XCODEBUILD=1 pod repo push --allow-warnings --use-libraries --verbose tag_publish_source $RELEASE_SRCSPEC)
        handleBackUpBranch "$PUSH_RET"
    else
        echo "No custom source, pushing to cocoapods master repo"
        PUSH_RET=$(pod trunk push --allow-warnings --use-libraries --verbose)
        handleBackUpBranch "$PUSH_RET"
    fi
fi