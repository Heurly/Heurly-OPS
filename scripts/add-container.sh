#!/bin/bash



if [ "$#" -ne 1 ]; then
    echo "Error: Name of the branch required"
    exit 1
fi

SERVICE=$1
domain=heurly.fr
url=$SERVICE.$domain
if [ $SERVICE = "main" ]; then
    url=$domain
fi

racine=/home/share/hub




# Désactive le container

cd $racine/containers
mkdir $url
sed "s/{{SERVICE}}/$SERVICE/g" $racine/model/model.yml > $url/docker-compose.yml
cd $url
cp $racine/.env .env
echo "NEXTAUTH_URL=https://$url" >> .env
echo "NEXT_PUBLIC_APP_URL=https://$url" >> .env
docker-compose pull
docker-compose up -d
# Check if the site is already in the Caddyfile
if [ $SERVICE != "main" ]; then
    if grep -q "$url" "$racine/caddy/Caddyfile"; then
        echo "Site ($url) already in the Caddyfile"
        exit 0
    else
        echo "$url {
        reverse_proxy $SERVICE.heurly:3003
    }
    " >> "$racine/caddy/Caddyfile"
        echo "Site ($url) added in the Caddyfile"
    fi
fi


# Redémarrer le proxy reverse

cd $racine/caddy
docker-compose restart
