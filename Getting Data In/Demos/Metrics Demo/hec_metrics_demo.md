## HEC to Metrics Demo

### Create metrics index

Use Splunk Web. Name the index metrics_index.

## Create HEC token which sends to a metrics index

    curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http -d name=basic_metrics_token -d index=metrics_index -d token=21bfe5d4-bcb0-401c-ab93-0e2bf6deb58f

### Send to metrics index over HEC

    curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk 21bfe5d4-bcb0-401c-ab93-0e2bf6deb58f' -d '{"time": 1486683865.000,"event":"metric","source":"disk","host":"host_99","fields":{"region":"us-west-1","datacenter":"us-west-1a","rack":"63","os":"Ubuntu16.10","arch":"x64","team":"LON","service":"6","service_version":"0","service_environment":"test","path":"/dev/sda1","fstype":"ext3","_value":1099511627776,"metric_name":"total"}}'