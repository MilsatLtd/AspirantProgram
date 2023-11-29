# Milsat Aspirant Program - Admin Panel

## Overview
Admin panel for the Milsat Aspirant Program, built with ReactJS. It runs on port 3001 and is accessible at [https://admin-asp.milsat.africa/](https://admin-asp.milsat.africa/).

## Installation

1. Set up Node Version Manager (NVM):
export NVM_DIR="/home/ubuntu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

2. Install dependencies and build:
cd ~/AspirantProgram/src/admin/
npm install
npm run build

3. Serve the application:
cd dist/
tmux kill-session -t admin-app 2>/dev/null || true
tmux new -d -s admin-app "serve -s -l 3001"

## Nginx as Reverse Proxy
Nginx is configured to serve this application on port 3001.

## Deployment
Automated via GitHub Actions using `.github/workflows/Admin-Deployment.yml`.
