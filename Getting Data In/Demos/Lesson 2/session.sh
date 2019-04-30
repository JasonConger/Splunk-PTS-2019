#doitlive speed: 1
nano /opt/splunk/splunk_725/etc/apps/search/local/inputs.conf
#doitlive speed: 100
curl -k https://localhost:8088/services/collector?token=29a0a10d-adc3-4058-a3d4-99f0a322e6a2 -d '{"event": "Hello, world! Token as param.", "sourcetype": "mysourcetype"}'