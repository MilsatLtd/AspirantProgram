#!/bin/bash

# Download Node.js 16.13.0 installer script
curl -fsSL https://nodejs.org/dist/v16.13.0/node-v16.13.0-linux-x64.tar.xz -o node-v16.13.0-linux-x64.tar.xz

# Extract the tarball to /usr/local (this will create a directory /usr/local/node-v16.13.0-linux-x64)
sudo tar -Jxf node-v16.13.0-linux-x64.tar.xz -C /usr/local

# Create a symbolic link to make node and npm commands available system-wide
# sudo ln -s /usr/local/node-v16.13.0-linux-x64/bin/node /usr/local/bin/node
# sudo ln -s /usr/local/node-v16.13.0-linux-x64/bin/npm /usr/local/bin/npm
# sudo ln -s /usr/local/node-v16.13.0-linux-x64/bin/npx /usr/local/bin/npx
