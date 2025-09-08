#!/bin/bash

# Download Amazon Q Deb file
wget https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.deb
sudo dpkg -i amazon-q.deb
sudo apt-get install -f
