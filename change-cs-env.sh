#!/bin/bash

UXA_CONFIG="app/config/parameters.yml"
PP_CONFIG="../project-parameters/conf/env.json"
CAF_CONFIG="../cs-app-feature/conf/env.json"

PS3='Choose your env: '
options=("dev" "future" "next1" "next2" "next3" "next4" "next5" "staging" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "future")
            echo "you chose $opt"
            HOST="future-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="root"
            PASS="fe4eiN5cu2ai"
            PORT="null"
            break
            ;;
        "next1")
            echo "you chose $opt"
            HOST="next1-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="root"
            PASS="DohHop2Toolee7mei"
            PORT="null"
            break
            ;;
        "next2")
            echo "you chose $opt"
            HOST="next1-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="root"
            PASS="DohHop2Toolee7mei"
            PORT="null"
            break
            ;;
        "next3")
            echo "you chose $opt"
            HOST="next1-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="root"
            PASS="DohHop2Toolee7mei"
            PORT="null"
            break
            ;;
        "next4")
            echo "you chose $opt"
            HOST="next1-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="root"
            PASS="DohHop2Toolee7mei"
            PORT="null"
            break
            ;;
        "next5")
            echo "you chose $opt"
            HOST="next1-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="root"
            PASS="DohHop2Toolee7mei"
            PORT="null"
            break
            ;;
        "staging")
            echo "you chose $opt"
            HOST="preprod-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="root"
            PASS="DohHop2Toolee7mei"
            PORT="null"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

PS3='Choose your hpg: '
options=("dev" "future" "next1" "staging" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "future")
            HPG="http:\/\/hpg-future.csq.io:8080"
            echo "you chose $opt : $HPG"
            break
            ;;
        "next1")
            HPG="http:\/\/hpg-next1.csq.io:8080"
            echo "you chose $opt : $HPG"
            break
            ;;
        "staging")
            HPG="http:\/\/stg-staging.csq.io"
            echo "you chose $opt : $HPG"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

sed -i.bak "s/\(database_host: *\).*/\1"$HOST"/" $UXA_CONFIG
sed -i.bak "s/\(database_port: *\).*/\1"$PORT"/" $UXA_CONFIG
sed -i.bak "s/\(database_name: *\).*/\1"$DB"/" $UXA_CONFIG
sed -i.bak "s/\(database_user: *\).*/\1"$USERDB"/" $UXA_CONFIG
sed -i.bak "s/\(database_password: *\).*/\1"$PASS"/" $UXA_CONFIG

sed -i.bak "s/\(\"database\": *\"\).*/\1"$DB"\",/" $PP_CONFIG
sed -i.bak "s/\(\"host\": *\).*/\1\""$HOST"\",/" $PP_CONFIG
sed -i.bak "s/\(\"port\": *\).*/\1"$PORT",/" $PP_CONFIG
sed -i.bak "s/\(\"username\": *\).*/\1\""$USERDB"\",/" $PP_CONFIG
sed -i.bak "s/\(\"password\": *\).*/\1\""$PASS"\"/" $PP_CONFIG

sed -i.bak "s/\(hypergate_api_url: *\).*/\1 "$HPG"/" $UXA_CONFIG
sed -i.bak "/\"hpg\":/{n;s/.*/        \"url\": \"$HPG\"/}" $CAF_CONFIG

# faire un upgrade de la base symfony !!
# docker exec -it common_php55_1 php /var/www/dev-uxanalytics.content-square.fr/app/console doctrine:schema:update --force 

# clear en forcant le cache symfony
docker exec -it common_php55_1 rm -rf /var/cache/symfony

# Erase all docker images
#docker rm $(docker ps -a -q)
#docker rmi $(docker images -q) -f
