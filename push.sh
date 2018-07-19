#!/usr/bin/env bash

update_readme() {
  ls wheelhouse | sort | awk '{print "["$0"](wheelhouse/"$0")\n"}' > README.md
}

commit_files() {
  git pull origin master
  update_readme
  git add README.md wheelhouse/*
  git status
  git commit --message "Travis build: $TRAVIS_JOB_NUMBER"
}

fetch_diff() {
  git reset HEAD~
  git checkout README.md
  commit_files
}

git_push() {
    git push --quiet travis HEAD:master
}

upload_files() {
  git remote add travis https://michael-kotliar:${GH_TOKEN}@github.com/michael-kotliar/cwl-airflow-wheels.git > /dev/null 2>&1
  while ! git_push
    do
      echo "Failed to push changes"
      sleep 1
      fetch_diff
      (( count++ ))
      if [ $count == 60 ]
      then
        break
      fi
  done
  echo "Pushed changes"
}

commit_files
upload_files