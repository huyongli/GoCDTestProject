#!/bin/bash

echo '✈ -------------------------------------------- ✈'
echo 'parse params...'
API_TOKEN=$1
APP_ID=$2
APK_PATH=$3
APP_NAME=$4
BUILD_ID=$5


echo '✈ -------------------------------------------- ✈'
echo 'Get fir credential...'
credential=$(curl -X "POST" "http://api.fir.im/apps" \
-H "Content-Type: application/json" \
-d "{\"type\":\"android\", \"bundle_id\":\"${APP_ID}\", \"api_token\":\"${API_TOKEN}\"}" \
2>/dev/null)
binary_response=$(echo ${credential} | grep -o "binary[^}]*")
KEY=$(echo ${binary_response} | awk -F '"' '{print $5}')
TOKEN=$(echo ${binary_response} | awk -F '"' '{print $9}')
UPLOAD_URL=$(echo ${binary_response} | awk -F '"' '{print $13}')

echo '✈ -------------------------------------------- ✈'
echo 'Uploading to fir...'
response=$(curl -F "key=${KEY}" \
-F "token=${TOKEN}" \
-F "file=@${APK_PATH}" \
-F "x:build=${BUILD_ID}" \
${UPLOAD_URL}
)
echo $response;