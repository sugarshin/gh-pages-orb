Setup() {
    U=$(eval echo "$USERNAME")
    R=$(eval echo "$REPONAME")
    GIT_URL="git@${GIT_HOST}:${U}/${R}.git"
    if [[ -d ./.git ]]; then
        MESSAGE="Built artifacts of $(git rev-parse --short HEAD) [ci skip]"
    else
        MESSAGE="Built artifacts of latest commit [ci skip]"
    fi
}

SetCommitMessage() {
    if [ -n "${COMMIT_MESSAGE}" ]; then
        MESSAGE="${COMMIT_MESSAGE}"
    fi
}

Clone() {
    rm -rf "${TMP_DIR}"
    git clone --depth=1 "${GIT_URL}" -b "${BRANCH}" "${TMP_DIR}" || (git init "${TMP_DIR}" && cd "${TMP_DIR}" && git remote add origin "${GIT_URL}" && git checkout -b "${BRANCH}" && cd - || return)
}

UpdateAssets() {
    # shellcheck disable=SC2115
    rm -rf "${TMP_DIR}"/*
    cp -R "${TMP_DIR}"/../"${DIST_DIR}"/. "${TMP_DIR}"
}

Push() {
    cd "${TMP_DIR}" || return
    git add --all
    git commit -m "${MESSAGE}" || true
    git push origin "${BRANCH}"
}

Main() {
    Setup
    SetCommitMessage
    Clone
    UpdateAssets
    Push
}

ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    Main
fi
