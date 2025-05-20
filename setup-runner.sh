#!/bin/bash

# Update OS
sudo yum update -y

# Install dependencies
curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
sudo chmod +x /usr/local/bin/gitlab-runner

# Install and start gitlab-runner as a service
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo systemctl start gitlab-runner

# Register runner (replace placeholders below)
sudo gitlab-runner register --non-interactive \
  --url "https://gitlab.com/" \
  --registration-token "YOUR_REGISTRATION_TOKEN" \
  --executor "shell" \
  --description "ec2-runner" \
  --tag-list "self-hosted" \
  --run-untagged="true" \
  --locked="false"

sudo systemctl enable gitlab-runner
