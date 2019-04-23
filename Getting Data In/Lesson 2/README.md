# Splunk PTS 2019 - GDI - Lesson 2

Send a HEC token in the URL as a query string parameter.

## Enable

    $SPLUNK_HOME/etc/apps/(splunk_httpinput|app name)/local/inputs.conf
    
    [http://<token_name>]
    allowQueryStringAuth = true
    
Disable/enable your token after making the above change.

## Test

### *nix/Mac
    curl -k http://localhost:8088/services/collector?token=<token> -d '{"event": "Hello, world! Token as param.", "sourcetype": "mysourcetype"}'

### Windows PowerShell
    Invoke-WebRequest -Uri "http://127.0.0.1:8088/services/collector?token=<token>" -Method Post -Body '{"sourcetype":"mysourcetype","event":"Hello, world! Token as param."}'