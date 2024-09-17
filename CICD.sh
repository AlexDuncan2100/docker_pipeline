#!/bin/bash
set -e

APP_NAME=mywebapp
VERSION=INSECURE

#BUILD: Clean up old container/build image
docker rm -f $APP_NAME 2>/dev/null || true
docker build -t $APP_NAME:$VERSION . 

docker scout cves $APP_NAME:$VERSION --output ./vulns.report
docker scout cves $APP_NAME:$VERSION --only-severity critical --exit-code
docker scout sbom --output $APP_NAME.sbom $APP_NAME:$VERSION

#TEST: Run the container using the image you just built
docker run -d -p 80:80 --name $APP_NAME $APP_NAME:$VERSION



