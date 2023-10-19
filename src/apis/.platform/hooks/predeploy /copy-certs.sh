#!/bin/bash

# Download the certificates from S3
sudo aws s3 cp s3://ssl-tls-certificates-bucket/Fluid-monitoring-certs/fullchain.pem /etc/pki/tls/certs/fullchain.pem
sudo aws s3 cp s3://ssl-tls-certificates-bucket/Fluid-monitoring-certs/privkey.pem /etc/pki/tls/private/privkey.pem
