#!/bin/sh
## flatten 
#awk -v RS= '{$1=$1}1' demo.json
#source vars if file exists


DEFAULT=/etc/default/fluentd
echo "setting the target logyfile to $LOGFILEPATH"
env
[ -z "$LOGFILEPATH" ] && echo "VAR LOGFILEPATH not set" 
sed  -i 's@path .*@path '"$LOGFILEPATH"'@' /fluentd/etc/fluent.conf  
sed -i  's@pos_file .*@pos_file '"$LOGFILEPATH.pos"'@' /fluentd/etc/fluent.conf  
[ -z "$WORKSPACEID" ] && echo "VAR  WORKSPACEID not set" 
sed  -i 's@customer_id .*@customer_id '"$WORKSPACEID"'@' /fluentd/etc/fluent.conf  
[ -z "$WORKSPACEKEY" ] && echo "VAR WORKSPACEKEY not set" 
sed  -i  's@shared_key .*@shared_key '"$WORKSPACEKEY"'@' /fluentd/etc/fluent.conf  

[ -z "$LOGTABLE" ] && echo "VAR LOGTABLE not set" 
sed  -i 's@log_type .*@log_type '"$LOGTABLE"'@' /fluentd/etc/fluent.conf  
 
cat /fluentd/etc/fluent.conf
if [ -r $DEFAULT ]; then
    set -o allexport
    . $DEFAULT
    set +o allexport
fi

# If the user has supplied only arguments append them to `fluentd` command
if [ "${1#-}" != "$1" ]; then
    set -- fluentd "$@"
fi

# If user does not supply config file or plugins, use the default
if [ "$1" = "fluentd" ]; then
    if ! echo $@ | grep ' \-c' ; then
       set -- "$@" -c /fluentd/etc/${FLUENTD_CONF}
    fi

    if ! echo $@ | grep ' \-p' ; then
       set -- "$@" -p /fluentd/plugins
    fi
fi

exec "$@"