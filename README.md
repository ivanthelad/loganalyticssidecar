# loganalyticssidecar
Sidecar to collect json based logs. 

simple demostration of a log analytics side car to collect application logs  that are in json format and pump them to Log analytics under a customer schema 

 * LOGFILEPATH /tmp/mylog.json : the path where the log file is sitting. this can also be a pattern 
 * LOGTABLE the table where the logs should be stored. found under custom logs _CL  
 * WORKSPACEID: Log analytics workspace id 
 * ENV WORKSPACEKEY: : Log analytics workspace key


the image (main container in pod) https://hub.docker.com/r/ivmckinl/jsonloggenerator generates  a bunch of dummy data under the path /tmp/mylog.json.  which is shared between the side car and the main container 

## to deploy 
 kubectl apply -f deployment.yaml 


