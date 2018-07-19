#!/bin/zsh
branch_name=`git rev-parse --abbrev-ref @`
repo_name=$(basename `git rev-parse --show-toplevel`)

# build or deploy?
[[ $1 = 'deploy' ]] && activity="_deploy" || activity=""

xdg-open https://app.ci.csq.fr/blue/organizations/jenkins/github_organization$activity%2F$repo_name/activity </dev/null &>/dev/null &
