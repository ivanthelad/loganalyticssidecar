FROM fluent/fluentd:v1.6-1
## file path to insepct 
ENV LOGFILEPATH /tmp/mylog.json
ENV WORKSPACEID "f"
ENV WORKSPACEKEY "d"
ENV LOGTABLE jsonlogs
## TO RUN 
#docker run -e WORKSPACEID="xxxx" -e  WORKSPACEKEY="xxxxvjKgXQEfLqMjxxxxxHJ+RJGZdfSExxxx" tempy:latest 
# Use root account to use apk
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 &&  sudo gem install fluent-plugin-azure-loganalytics \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/fluent.conf 
COPY entrypoint.sh /bin/
COPY demo.json /bin/
RUN chmod 775  -R /var/log
RUN chmod  757  -R /fluentd/etc/
USER fluent