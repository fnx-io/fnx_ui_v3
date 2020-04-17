#!/bin/sh

webdev build &&
cd build &&
gcloud compute scp * static-ma:/usr/share/nginx/www/ui.fnx.io/ --recurse --project "ma-web" --zone "europe-west1-b";
