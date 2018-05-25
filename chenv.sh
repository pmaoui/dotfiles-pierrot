#!/bin/zsh

UXA_CONFIG="$WORKSPACE/mousetest/app/config/parameters.dev.yml"
PP_CONFIG="$WORKSPACE/project-parameters/conf/env.json"
CAF_CONFIG="$WORKSPACE/cs-app-feature/conf/env.json"
VIM=$(which vim)

environnements=(dev production next1 next2 next3 next4 next5 staging Quit)
select opt in "${environnements[@]}"
do
    case $opt in
        "dev"|"production"|"next1"|"next2"|"next3"|"next4"|"next5"|"staging")

            # UXA
            echo "Doing UXA..."
            APP_CONF_UXA="$WORKSPACE/app-conf/uxanalytics/$opt/eu-west-1/parameters.yml"
            APP_CONF_UXA_DEV="$WORKSPACE/app-conf/uxanalytics/dev/eu-west-1/parameters.yml"
            uxa_lines=('hypergate_api_url' 'us.hypergate_api_url' 'cs_app_feature_api_url' 'database_host' 'database_name' 'database_user' 'database_password' 'env_prefix')
            for line in $uxa_lines; do
              line_appconf=`cat $APP_CONF_UXA | grep -m1 "^ *$line.*:"`
              # we need the dev one for this line
              if [ "$line" = "cs_app_feature_api_url" ]; then
                line_appconf=`cat $APP_CONF_UXA_DEV | grep -m1 "^ *$line.*:"`
              fi
              if [ -n "$line_appconf" ]; then
                vim -c "g/^ *$line.*:/s/^.*/${line_appconf//\//\\/}" -c "wq" $UXA_CONFIG
                echo $(cat $UXA_CONFIG| grep $line)
              else
                echo "No line in $UXA_CONFIG for : $line";
              fi
            done

            # PROJECT-PARAMETERS
            echo "Doing PP..."
            APP_CONF_PP="$WORKSPACE/app-conf/project-parameters/$opt/eu-west-1/env.json"
            pp_lines=('host' 'database' 'username' 'password')
            for line in $pp_lines; do
              line_appconf=`cat $APP_CONF_PP | grep -v "{" | grep -m1 "$line.*:"`
              if [ -n "$line_appconf" ]; then
                vim -c "g/\v^(.*$line.*:)&(.*\{)@!/s/^.*/${line_appconf//\//\\/}" -c "wq" $PP_CONFIG
                echo $(cat $PP_CONFIG| grep $line)
              else
                echo "No line in $PP_CONFIG for : $line";
              fi
            done

            # CS-APP-FEATURE (HPG)
            echo "Doing CAF..."
            APP_CONF_CAF="$WORKSPACE/app-conf/cs-app-feature/$opt/eu-west-1/env.json"
            caf_lines=('"hpg"' 'hpg-replay' 'hpgm-mapping' 'hpgm-screengraph' 'hpgm-zoning')
            for line in $caf_lines; do
              line_appconf=`cat $APP_CONF_CAF | grep $line -A1 | grep -m1 "url.*:"`
              if [ -n "$line_appconf" ]; then
                # the line_appconf needs to escape slash
                vim -c "g/.*$line.*:/+s/^.*/${line_appconf//\//\\/}" -c "wq" $CAF_CONFIG
                echo $(cat $CAF_CONFIG| grep $line -C 1)
              else
                echo "No line in $CAF_CONFIG for : $line";
              fi
            done

            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
