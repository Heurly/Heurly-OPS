#!/bin/bash



if [ "$#" -ne 1 ]; then
    echo "Error: URL required"
    exit 1
fi

SERVICE=$1
domain=heurly.fr
url=$SERVICE.$domain
if [ $SERVICE = "main" ]; then
    url=$domain
fi

racine="$(pwd)"
if [ $SERVICE != "main" ]; then
    if grep -q "$url" $racine/caddy/Caddyfile; then
        # Remove the site from the Caddyfile
        sed -i "/$url {/,/}/d" $racine/caddy/Caddyfile
        echo "Site $url removed from the Caddyfile"
    else
        echo "Site ($url) not found in the Caddyfile"
        exit 0
    fi
fi
# Check if the site is already in the Caddyfile



# Redémarrer le proxy reverse

cd $racine/caddy
docker compose restart


# Désactive le container

if [ -d "$racine/containers/$url" ]; then
  echo "Le dossier $racine/containers/$url existe."
  cd "$racine/containers/$url" || exit
  docker compose down
  docker rmi domesday/heurly:$SERVICE
  cd "$racine" || exit
  rm -rf "containers/$url"
  echo "Le dossier $racine/containers/$url a été supprimé."
else
  echo "Le dossier $racine/containers/$url n'existe pas."
fi


