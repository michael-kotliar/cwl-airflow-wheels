#!/usr/bin/env bash

update_readme() {
  ls wheelhouse | sort | awk '{print "["$0"](wheelhouse/"$0")\n"}' > README.md
}

commit_files() {
  git pull origin master
  update_readme
  git add README.md wheelhouse/*
  git status
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

fetch_diff() {
  git reset HEAD~
  git checkout README.md
  commit_files
}

upload_files() {
  git remote add travis https://michael-kotliar:${GH_TOKEN}@github.com/michael-kotliar/cwl-airflow-wheels.git > /dev/null 2>&1
  if git push --quiet travis HEAD:master
  then
    echo "git push succeeded"
  else
    fetch_diff
    git push --quiet travis HEAD:master
  fi
}

commit_files
upload_files