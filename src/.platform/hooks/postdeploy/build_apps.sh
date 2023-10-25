#!/bin/bash
cd /var/app/current/admin && npm install && npm run build
cd /var/app/current/web && npm install && npm run build
