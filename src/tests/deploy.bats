setup() {
    source ./src/scripts/deploy.sh
}

@test 'Setup' {
    export GIT_HOST=github.com
    export USERNAME=sugarshin
    export REPONAME=gh-pages-orb
    Setup
    [ "${GIT_URL}" == 'git@github.com:sugarshin/gh-pages-orb.git' ]
}

@test 'SetCommitMessage' {
    export COMMIT_MESSAGE=yo
    SetCommitMessage
    [ "${MESSAGE}" == 'yo' ]
}
