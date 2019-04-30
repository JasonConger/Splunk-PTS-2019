# Splunk PTS 2019 - GDI - Lesson 1
Creating and testing HEC.

## Create
From Splunk Web:

  * Settings -> Data inputs
  * Click HTTP Event Collector
  * Click New Token
    * Name = PTS
    * Source name override = leave blank
    * Description = leave blank
    * Output Group = None
    * Enable indexer acknowledgement = unchecked
  * Click Next
    * Source type = Automatic
    * App Context = Search & Reporting
    * Select Allowed Indexes = leave as-is
    * Default Index = Default
  * Click Review
  * Click Submit
  * Copy the Token Value

## Enable
From Splunk Web:

  * Settings -> Data inputs
  * Click HTTP Event Collector
  * Click Global Settings
    * All Tokens = Enabled
    * Default Source Type = leave as-is
    * Default Index = Default
    * Default Output Group = None
    * Use Deployment Server = unchecked
    * Enable SSL = checked
    * HTTP Port Number 8088
  * Click Save

## Test

### *nix/Mac
    curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk <token>' -d '{"sourcetype": "mysourcetype", "event":"Hello, World!"}'

### Windows PowerShell
    Invoke-WebRequest -Uri "https://127.0.0.1:8088/services/collector" -Headers @{"Authorization"="Splunk <token>"} -Method Post -Body '{"sourcetype":"mysourcetype","event":"Hello World!"}'

