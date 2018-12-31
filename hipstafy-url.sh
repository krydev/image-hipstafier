#!/bin/bash

. ticktick.sh

if [ $# -ne 1 ]; then
    echo "Usage: ./hipstafy-url.sh <image-url>"
else
    credsPath="imgur-creds"
    curl -s -O "$1"
    imgname=$(basename "$1")
    echo "$imgname has been downloaded!"
    ./hipstafy.sh $imgname
    if [ $? -ne 0 ]; then
        echo "Failed to convert the image. Quitting..." >&2; exit 1
    else
        echo "$imgname has been hipstafied!"
        rm $imgname
        prefix=${imgname%.*}
        converted=$(echo $prefix-hipstah.*)
        clientId=$(cat "$credsPath/client.id")

        authHeader="Authorization: Client-ID $clientId"
        response="$(curl -s -H "$authHeader" -F "image=@$converted" https://api.imgur.com/3/image)"
        
        tickParse "$response"
        link="``data["link"]``"
        #using parameter substitution to unescape the url
        echo "Hipstafied image has been uploaded. Here's your link: ${link//\\/}"
        rm $converted
    fi
fi
