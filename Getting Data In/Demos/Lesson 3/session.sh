#doitlive speed: 1
curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http -d name=basic_token
#doitlive speed: 100
curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk 29a0a10d-adc3-4058-a3d4-99f0a322e6a2' -d '{"event":"Hello, Basic Token World!", "sourcetype": "mysourcetype"}'
#doitlive speed: 1
curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http -d name=enabled_token -d description="This token was created programatically" -d disabled=1
curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http/enabled_token -d disabled=0
#doitlive speed: 100
curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk 29a0a10d-adc3-4058-a3d4-99f0a322e6a2' -d '{"event":"Hello, Specific Token World!", "sourcetype": "mysourcetype"}'
curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http -d name=custom_guid_value_token -d token=9719f55f-fc05-4cbe-839b-dc955f25e858
curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk 9719f55f-fc05-4cbe-839b-dc955f25e858' -d '{"event":"Hello, Custom GUID World!", "sourcetype": "mysourcetype"}'
#doitlive speed: 1
curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http -d name=custom_value_token -d token=whateveriwant
curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk whateveriwant' -d '{"event":"Hello, Custom Token World!", "sourcetype": "mysourcetype"}'