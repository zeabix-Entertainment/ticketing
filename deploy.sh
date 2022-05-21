#!/bin/bash

echo "Deploy to development environment"
echo "Deploy by: $GITLAB_USER_LOGIN"
echo "Application: $CI_PROJECT_NAME"
echo "Tag: $CI_COMMIT_TAG"

#CI_PROJECT_NAME="activity-service"

#authorized=(root prawit.c benzz3d onikingkong)

#case "${authorized[@]}" in
#       *"$GITLAB_USER_LOGIN"*) echo "Authorized" ;;
#       *)
#               echo "User: $GITLAB_USER_NAME is authorized to deploy to production"
#               exit -1
#               ;;
#esac


git clone https://thaihealth-cd:Fqc6FKl0nBf4dOXnAZk@gitlab.dev.jigsawgroups.work/cicd/thaihealth-cd.git
cd thaihealth-cd
git fetch --all
git checkout dev

if [[ "$CI_PROJECT_NAME" == "thaihealth-web" ]]; then
         echo "$CI_COMMIT_TAG"
         yq e '.thaihealthWeb.tag=strenv(CI_COMMIT_TAG)' -i ./values.yaml
elif [[ "$CI_PROJECT_NAME" == "thaihealth-20th" ]]; then
         yq e '.thaihealth20th.tag=strenv(CI_COMMIT_TAG)' -i ./values.yaml
fi

git config --global user.name "Gitlab CD"
git config --global user.email "gitlab@jigsawgroups.work"

git add .
git commit -m "CD deployment with tag $CI_COMMIT_TAG"
git push
cd ..
rm -rf thaihealth-cd


##  yq e '.client.tag="kai1"' -i ./values.yaml