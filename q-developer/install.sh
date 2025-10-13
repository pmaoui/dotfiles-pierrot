#!/bin/bash

# Download Amazon Q Deb file
wget https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.deb
sudo dpkg -i amazon-q.deb
sudo apt-get install -f

mkdir -p ~/.aws/amazonq/cli-agents
ln -s ~/.aws/amazonq/cli-agents/Pierrot-Principal-Agent.json Pierrot-Principal-Agent.json
