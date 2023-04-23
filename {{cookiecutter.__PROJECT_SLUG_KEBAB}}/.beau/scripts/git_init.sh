#!/bin/bash

if [ -d .git ]; then
  echo "Repository already initiated."
else
  git init
  git add . >/dev/null
  git commit -m "Instantiate XTS Template" --quiet
fi

if !(git remote | grep -q .); then \
  echo ""
  echo "Creating GitHub Repository"
  echo "=========================="
  echo ""
  echo "If you do not already have a remote repository in GitHub, create one here: https://github.dev.xero.com/new"
  echo ""
  echo "Skipping this step means you will only have a local git repository. You can set up a remote repository later if need be."
  echo ""

  read -p "Enter GitHub Repository URL: [enter to skip] " REPO_URL
  if [ -n "$REPO_URL" ]; then \
    git remote add origin "$REPO_URL"
    git push -u origin main
  fi
else \
  echo "Remote repository exists."
  echo ""
fi
