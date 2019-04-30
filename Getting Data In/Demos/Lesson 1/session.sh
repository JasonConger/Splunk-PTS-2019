#doitlive speed: 100
curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk 29a0a10d-adc3-4058-a3d4-99f0a322e6a2' -d '{"sourcetype": "mysourcetype", "event":"Hello, World!"}'