#!/bin/sh
CURRENT=$(git rev-parse --abbrev-ref HEAD)
SUPPOSED="main"
if [ "$CURRENT" = "$SUPPOSED" ]; then
    export $(grep -v '^#' ../.env | xargs -d '\n') && sed -e "s,\$ESVA_BACKEND,${E  SVA_BACKEND},g" ../validador/ui/configs/Configs.json.tmpl > ../validador/ui/configs/Configs.json
    git pull
    export $(grep -v '^#' ../.env | xargs -d '\n') && sed -e "s,\${HOST},${HOST},g" -e "s,\${DB_PASS},${DB_PASS},g" ../docker-compose.yml.tmpl > ../docker-compose.yml
    docker rm -f esvavalidator validador-core validador-ui validatornginx
    docker-compose up -d --build
else
    echo "You are not in the correct branch. Please change to $SUPPOSED branch."
fi