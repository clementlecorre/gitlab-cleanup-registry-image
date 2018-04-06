#!/bin/bash


## Params config
USERNAME=USERNAME
GITLAB_URL=gitlab.com
GITLAB_REGISTRY_URL=registry.gitlab.com
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


MAX_PAGE=$(curl -sSL -D - -o /dev/null -XGET -H "Content-Type:application/json" -H "PRIVATE-TOKEN: ${GITLAB_TOKEN}" https://${GITLAB_URL}/api/v4/projects?per_page=100 | tr -d "\015" | awk '/x-total-pages/ {print $NF}')
for (( page=1; page<=${MAX_PAGE}; page++ ))
do
    # Jwt login and Parse gitlab token auth
    curl -s -X GET -H "X-Page: ${page}" -H -H "Content-Type:application/json" -H "PRIVATE-TOKEN: ${GITLAB_TOKEN}" "https://${GITLAB_URL}/api/v4/projects?per_page=100&page=${page}" | jq -r '.[] | select(.container_registry_enabled==true) | .path_with_namespace | ascii_downcase' | while read projet; do
        images=0
        token=$(curl -s --user "${USERNAME}:${GITLAB_TOKEN}" "https://${GITLAB_URL}/jwt/auth?service=container_registry&scope=repository:${projet}:*" | jq -r '.token')
        tagslist=$(curl -s -H "Authorization: Bearer $token" "https://${GITLAB_REGISTRY_URL}/v2/${projet}/tags/list")
        if [[ "$(echo ${tagslist} | jq -r -c '.tags')" != "null" ]]
        then
            images=$(echo ${tagslist} | jq -r -c '.tags | length')
            echo "${images} images : ${projet}"
        fi
    done
done

