# Splunk PTS 2019 - GDI - Lesson 1

## *nix/Mac
    curl -k http://localhost:8088/services/collector -H 'Authorization: Splunk <token>' -d '{"sourcetype": "mysourcetype", "event":"Hello, World!"}'

## Windows PowerShell
    Invoke-WebRequest -Uri "http://127.0.0.1:8088/services/collector" -Headers @{"Authorization"="Splunk <token>"} -Method Post -Body '{"sourcetype":"mysourcetype","event":"Hello World!"}'

