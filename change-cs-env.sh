#!/bin/bash

UXA_CONFIG="$UXA_LOCAL_WORKSPACE/app/config/parameters.yml"
PP_CONFIG="$LOCAL_WORKSPACE/project-parameters/conf/env.json"
CAF_CONFIG="$LOCAL_WORKSPACE/cs-app-feature/conf/env.json"

######################
### OUTPUT METHODS ###
######################

success_msg () {
  echo -e "\e[92m✔ - $@"
}

warning_msg () {
  echo -e "\e[93m - $@"
}

error_msg () {
  echo -e "\e[91m✘ - $@"
}

blue_msg () {
  echo -e "\e[96m$@"
}

PS3='Choose your env: '
warning_msg "#############################################################"
warning_msg "################## CHOOSE YOUR DATABASE #####################"
warning_msg "#############################################################"
blue_msg ""
options=("dev" "future" "next1" "next2" "next3" "next4" "next5" "staging" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "dev")
            HOST="phpdb-dev.csq.io"
            DB="uxanalytics"
            echo "Enter database prefix (ex: pierrot_):"
            read DB_PREFIX
            DB="$DB_PREFIX$DB"
            USERDB="dev"
            PASS="UpdXJqyivfC7M"
            PORT="3306"
            success_msg "You have selected $DB - $opt : $HOST"
            break
            ;;
        "future")
            HOST="future-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="root"
            PASS="fe4eiN5cu2ai"
            PORT="null"
            success_msg "You have selected $DB - $opt : $HOST"
            break
            ;;
        "next1")
            HOST="next1-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="uxanalytics"
            PASS="DohHop2Toolee7mei"
            PORT="null"
            success_msg "You have selected $DB - $opt : $HOST"
            break
            ;;
        "next2")
            HOST="next2-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="uxanalytics"
            PASS="DohHop2Toolee7mei"
            PORT="null"
            success_msg "You have selected $DB - $opt : $HOST"
            break
            ;;
        "next3")
            HOST="next3-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="uxanalytics"
            PASS="DohHop2Toolee7mei"
            PORT="null"
            success_msg "You have selected $DB - $opt : $HOST"
            break
            ;;
        "next4")
            HOST="next4-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="uxanalytics"
            PASS="DohHop2Toolee7mei"
            PORT="null"
            success_msg "You have selected $DB - $opt : $HOST"
            break
            ;;
        "next5")
            HOST="next5-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="uxanalytics"
            PASS="DohHop2Toolee7mei"
            PORT="null"
            success_msg "You have selected $DB - $opt : $HOST"
            break
            ;;
        "staging")
            HOST="preprod-phpdb.cz6mty6zhfxl.eu-west-1.rds.amazonaws.com"
            DB="uxanalytics"
            USERDB="root"
            PASS="fe4eiN5cu2ai"
            PORT="null"
            success_msg "You have selected $DB - $opt : $HOST"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

warning_msg "#############################################################"
warning_msg "################## CHOOSE YOUR HYPERGATE ####################"
warning_msg "#############################################################"
blue_msg ""
PS3='Choose your hpg: '
options=("future" "next1" "staging" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "future")
            HPG="http:\/\/hpg-future.csq.io:8080"
            success_msg "You have selected - $opt : $HPG"
            break
            ;;
        "next1")
            HPG="http:\/\/hpg-next1.csq.io:8080"
            success_msg "You have selected - $opt : $HPG"
            break
            ;;
        "staging")
            HPG="http:\/\/stg-staging.csq.io"
            success_msg "You have selected - $opt : $HPG"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

sed -i "s/\(database_host: *\).*/\1"$HOST"/" $UXA_CONFIG
sed -i "s/\(database_port: *\).*/\1"$PORT"/" $UXA_CONFIG
sed -i "s/\(database_name: *\).*/\1"$DB"/" $UXA_CONFIG
sed -i "s/\(database_user: *\).*/\1"$USERDB"/" $UXA_CONFIG
sed -i "s/\(database_password: *\).*/\1"$PASS"/" $UXA_CONFIG

sed -i "s/\(\"database\": *\"\).*/\1"$DB"\",/" $PP_CONFIG
sed -i "s/\(\"host\": *\).*/\1\""$HOST"\",/" $PP_CONFIG
sed -i "s/\(\"port\": *\).*/\1"$PORT",/" $PP_CONFIG
sed -i "s/\(\"username\": *\).*/\1\""$USERDB"\",/" $PP_CONFIG
sed -i "s/\(\"password\": *\).*/\1\""$PASS"\"/" $PP_CONFIG

sed -i "s/\(hypergate_api_url: *\).*/\1 "$HPG"/" $UXA_CONFIG
sed -i "/\"hpg\":/{n;s/.*/        \"url\": \"$HPG\"/}" $CAF_CONFIG

# faire un upgrade de la base symfony !!
# docker exec -it common_php55_1 php /var/www/dev-uxanalytics.content-square.fr/app/console doctrine:schema:update --force 

# clear en forcant le cache symfony
docker exec -it common_php55_1 rm -rf /var/cache/symfony

# Erase all docker images
#docker rm $(docker ps -a -q)
#docker rmi $(docker images -q) -f
