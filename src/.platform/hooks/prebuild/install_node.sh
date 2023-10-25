#!/bin/bash

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Export NVM environment variable
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads NVM

# Install Node.js version 16.16.0 using NVM
nvm install 16

# Ensure npm is available
nvm use 16

# Add the following lines to ensure the PATH is updated for non-interactive shells
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo 'export PATH="$PATH:$HOME/.nvm/versions/node/$(nvm current)/bin"' >> ~/.bashrc
