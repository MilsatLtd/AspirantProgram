# Milsat Aspirant Program - Web Application

## Overview
Web application for the Milsat Aspirant Program, developed with NextJS and Tailwind CSS. It runs on port 3000 and is accessible at [https://aspirant.milsat.africa/](https://aspirant.milsat.africa/).

## Pre-requisites
Before beginning the installation process, ensure you have the following installed:
- Node.js
- npm
- Node Version Manager (NVM)
- tmux
- Nginx

Note: This step involves setting up NVM. For detailed instructions on NVM installation, refer to [NVM GitHub page](https://github.com/nvm-sh/nvm).

## Installation

1. Set up Node Version Manager (NVM):
export NVM_DIR="/home/ubuntu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

2. Install dependencies and build:
cd ~/AspirantProgram/src/web/
npm install  # Installs project dependencies
npm run build # Builds the application

3. Start the application using tmux:
tmux kill-session -t web-app 2>/dev/null || true  # Kills the existing 'web-app' tmux session if it exists
tmux new -d -s web-app "PORT=3000 npm start" # Starts a new tmux session named 'web-app' to serve the application

Note: We use tmux to manage application sessions. This allows the app to keep running in the background.

## Nginx as Reverse Proxy
Nginx is configured to serve this application on port 3000.

## Deployment
Automated via GitHub Actions using `.github/workflows/web-Deployment.yml`.





## OLDER README DOCUMENTATION

This is a [Next.js](https://nextjs.org/) project bootstrapped with [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `pages/index.tsx`. The page auto-updates as you edit the file.

[API routes](https://nextjs.org/docs/api-routes/introduction) can be accessed on [http://localhost:3000/api/hello](http://localhost:3000/api/hello). This endpoint can be edited in `pages/api/hello.ts`.

The `pages/api` directory is mapped to `/api/*`. Files in this directory are treated as [API routes](https://nextjs.org/docs/api-routes/introduction) instead of React pages.

This project uses [`next/font`](https://nextjs.org/docs/basic-features/font-optimization) to automatically optimize and load Inter, a custom Google Font.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js/) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/deployment) for more details.
