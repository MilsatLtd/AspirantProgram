# Milsat Aspirant Program - Admin Panel

## Overview
Admin panel for the Milsat Aspirant Program, built with ReactJS. It runs on port 3001 and is accessible at [https://admin-asp.milsat.africa/](https://admin-asp.milsat.africa/).

## Pre-requisites
Before beginning the installation process, ensure you have the following installed:
- Node.js
- npm
- Node Version Manager (NVM)
- tmux
- Nginx
- 
Note: This step involves setting up NVM. For detailed instructions on NVM installation, refer to [NVM GitHub page](https://github.com/nvm-sh/nvm).

## Installation

1. Set up Node Version Manager (NVM):
export NVM_DIR="/home/ubuntu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

2. Install dependencies and build:
cd ~/AspirantProgram/src/admin/
npm install  # Installs project dependencies
npm run build  # Builds the application

3. Serve the application:
cd dist/
tmux kill-session -t admin-app 2>/dev/null || true  # Kills the existing 'admin-app' tmux session if it exists
tmux new -d -s admin-app "serve -s -l 3001"  # Starts a new tmux session named 'admin-app' to serve the application

Note: We use tmux to manage application sessions. This allows the app to keep running in the background

## Nginx as Reverse Proxy
Nginx is configured to serve this application on port 3001.

## Deployment
Automated via GitHub Actions using `.github/workflows/Admin-Deployment.yml`.
