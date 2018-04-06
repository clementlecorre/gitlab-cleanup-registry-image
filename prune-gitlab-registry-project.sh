#!/bin/bash

set -e
## Params config
REPO="namespace/repo"
USERNAME=USERNAME
GITLAB_URL=gitlab.com
GITLAB_REGISRTY_URL=regisrty.gitlab.com
GITLAB_TOKEN=xxxx
REGEX_MATCHING="^issue-[0-9]+"
## -------------------------------


# Color constants
COLOR_BLACK='\033[30m'
COLOR_BLACK_BOLD='\033[0;30;1m'
COLOR_RED='\033[31m'
COLOR_RED_BOLD='\033[0;31;1m'
COLOR_GREEN='\033[32m'
COLOR_GREEN_BOLD='\033[0;32;1m'
COLOR_YELLOW='\033[33m'
COLOR_YELLOW_BOLD='\033[0;33;1m'
COLOR_BLUE='\033[34m'
COLOR_BLUE_BOLD='\033[0;34;1m'
COLOR_MAGENTA='\033[35m'
COLOR_MAGENTA_BOLD='\033[0;35;1m'
COLOR_CYAN='\033[36m'
COLOR_CYAN_BOLD='\033[0;36;1m'
COLOR_WHITE='\033[37m'
COLOR_WHITE_BOLD='\033[0;37;1m'
COLOR_RESET='\033[0m'


# Jwt login and Parse gitlab token auth
token=$(curl -s --user "${USERNAME}:${GITLAB_TOKEN}" "https://${GITLAB_URL}/jwt/auth?service=container_registry&scope=repository:${REPO}:*" | jq -r '.token')

# loop over all projets tags
curl -s -H "Authorization: Bearer $token" "https://${GITLAB_REGISRTY_URL}/v2/${REPO}/tags/list" | jq -r '.tags[]' | while read tags; do
    DIGEST=$(curl -sSL -D - -o /dev/null -XGET -H "Accept: application/vnd.docker.distribution.manifest.v2+json" -H "Authorization: Bearer $token" "https://${GITLAB_REGISRTY_URL}/v2/${REPO}/manifests/${tags}" | tr -d "\015" | awk '/Docker-Content-Digest/ {print $NF}')
    
    if echo $tags | grep -E "${REGEX_MATCHING}" > /dev/null
    then
        echo -e "[${COLOR_GREEN_BOLD}DELETING${COLOR_RESET}] ${GITLAB_REGISRTY_URL}/${REPO}:${tags}"
        echo -e "\t=> ${DIGEST}"
        curl -XDELETE -H "Accept: application/vnd.docker.distribution.manifest.v2+json" -H "Authorization: Bearer $token" "https://${GITLAB_REGISRTY_URL}/v2/${REPO}/manifests/${DIGEST}"
    else
        echo -e "[${COLOR_CYAN_BOLD}IGNORING${COLOR_RESET}] ${GITLAB_REGISRTY_URL}/${REPO}:${tags}"
    fi
done