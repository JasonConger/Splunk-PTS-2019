## HEC Ack Demo

### Generate data    
    curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk 55db8431-89c8-4941-9b70-c44bafd56cf7' -H "X-Splunk-Request-Channel: FE0ECFAD-13D5-401B-847D-77833BD77131" -d '{"event":"Hello, Basic Ack World!"}}'

    curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk 55db8431-89c8-4941-9b70-c44bafd56cf7' -H "X-Splunk-Request-Channel: FE0ECFAD-13D5-401B-847D-77833BD77131" -d '{"event":"Hello, Basic Ack World?"}}'

    curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk 55db8431-89c8-4941-9b70-c44bafd56cf7' -H "X-Splunk-Request-Channel: FE0ECFAD-13D5-401B-847D-77833BD77131" -d '{"event":"Hello, Basic Ack World???"}}'

### Query ackIds

    curl -k https://localhost:8088/services/collector/ack -H 'Authorization: Splunk 55db8431-89c8-4941-9b70-c44bafd56cf7' -H "X-Splunk-Request-Channel: FE0ECFAD-13D5-401B-847D-77833BD77131" -d '{"acks":[0,1,2]}'

On second call, all ackIds will show as False. You get one shot!

    curl -k https://localhost:8088/services/collector/ack -H 'Authorization: Splunk 55db8431-89c8-4941-9b70-c44bafd56cf7' -H "X-Splunk-Request-Channel: FE0ECFAD-13D5-401B-847D-77833BD77131" -d '{"acks":[0,1,2]}'