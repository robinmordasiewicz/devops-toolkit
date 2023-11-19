#!/bin/bash
#

google-chrome --headless=new --screenshot="docs/img/github-profile.png" --hide-scrollbars --window-size=1620,1080 "https://github.com/robinmordasiewicz"

#google-chrome --headless=new --screenshot="docs/img/github-fork-repo.png" --hide-scrollbars --window-size=1620,1080 "https://github.com/robinmordasiewicz/devops-toolkit/fork"

#sgpt --code "write a markdown page to let people know how to sign up for github copilot" > docs/github-copilot.md
#sgpt --code "writes markdown page to describe a demo where a user forks a github repository robinmordasiewicz/devops-toolkit branch named feature1 is created for a user to make their commits. The style guide conventional commits is used as a reference in creating commits. The use will use opencommit command from a zsh shell. In the markdown guide, create steps as an unordered list. Also in the markdown file show the bash commands to execute each step. Give each section a short title. As a pre-requisite instruction, have users install opencommit from github and use the cli command oco to stage, commit and push changes. Highlight a step that demonstrates following style guides for commits such as the conventional commits style guide. The user will use the opencommit command from a zsh shell. In the markdown guide, create steps as an unordered list. Also in the markdown file show the bash commands to execute each step. Give each section a short title." > docs/demo.md

#sgpt --code "write a markdown page informing readers that subsequent steps in the instructions require opencommit to be installed install with the instructions found on this website https://github.com/di-sukharev/opencommit. Title the markdown page as OpenCommit" >docs/opencommit.md
#sgpt --code "write a markdown page instructing users step by step how to install opencommit from github. Keep the titles of each section three words." >docs/opencommit-install.md
#sgpt --code "write a markdown page instructing users step by step how to configure opencommit to use conventional commits style. Keep the titles of each section three words." >docs/opencommit-conventional.md

#sgpt --code "write a markdown page instructing users step by step how to install copilot as a vim plugin. Include a Usage section in the markdown documentation to show how see if copilot is active in vim. Keep the page title to three words." >docs/github-copilot-install.md

#sgpt --code "write a markdown page instructing users step by step with short titles and sections, how to sign up for a DockerHub account" >docs/account-docker.md

#sgpt "write a markdown file that lets people know that this is the beginning of a guide that requires users to have login accounts in github with copilot, azure, docker, and openai. For each of the accounts in the list, include the login page as a link in markdown. Make the title of the markdown document 'Accounts'. Do not use please and thank you in the documentation" >docs/accounts.md
