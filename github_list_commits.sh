#!/usr/bin/env bash

# Get the number of commits for a repository using the GitHub API
# Requires curl and jshon: http://kmkeen.com/jshon/
#
# Replace the value of repo_owner, repo_name and first_commit with
# the respective values for your repository.

# Owner of the repository
repo_owner="notfoss"

# Name of the repository
repo_name="archlinux-openrc-services"

# URL for the API request
repo_api_url="https://api.github.com/repos/${repo_owner}/${repo_name}"

# Hashes of the first and the latest commits
# Replace this with the hash of the first commit for your repository
first_commit="041f4e99d95c70188f5d564f8af2c203b6a072ca"

# Hash of the latest commit is fetched through the GitHub API
latest_commit=$(curl -s "$repo_api_url"/git/refs/heads/master | jshon -e object | jshon -e sha -u)

# Data returned by the GitHub API in JSON format
github_data=$(curl -s "$repo_api_url"/compare/"${first_commit}"..."${latest_commit}")

# Get the value of the total_commits key
num_commits=$(echo "$github_data" | jshon -e total_commits)

# Total number of commits = (value of the total_commits key) + 1
echo $(( num_commits + 1 ))
