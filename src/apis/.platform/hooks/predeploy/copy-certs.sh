#!/bin/bash

# Download the certificates from S3
sudo aws s3 cp s3://ssl-tls-certificates-bucket/map-api-certs/fullchain.pem /etc/pki/tls/map-api/fullchain.pem
sudo aws s3 cp s3://ssl-tls-certificates-bucket/map-api-certs/privkey.pem /etc/pki/tls/map-api/privkey.pem
