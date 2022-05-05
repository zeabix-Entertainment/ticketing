#!/bin/bash

echo "Deploy to development environment"
echo "Deploy by: $GITLAB_USER_LOGIN"
echo "Application: $CI_PROJECT_NAME"
echo "Tag: $CI_COMMIT_TAG"

#CI_PROJECT_NAME="activity-service"

authorized=(root prawit.c benzz3d onikingkong)

case "${authorized[@]}" in
        *"$GITLAB_USER_LOGIN"*) echo "Authorized" ;;
        *)
                echo "User: $GITLAB_USER_NAME is authorized to deploy to production"
                exit -1
                ;;
esac


git clone https://argocd:L1NFLYPtrypZW5dcX08@gitlab.dev.jigsawgroups.work/cicd/gssd-cd.git
cd gssd-cd
git fetch --all
git checkout dev

if [[ "$CI_PROJECT_NAME" == "gssd-wordpress" ]]; then
         echo "$CI_COMMIT_TAG"
         yq e '.gssdWeb.tag=strenv(CI_COMMIT_TAG)' -i ./values.yaml
fi

git config --global user.name "Gitlab CD"
git config --global user.email "gitlab@jigsawgroups.work"

git add .
git commit -m "CD deployment with tag $CI_COMMIT_TAG"
git push
cd ..
rm -rf gssd-cd