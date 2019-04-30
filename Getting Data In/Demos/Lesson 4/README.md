# Splunk PTS 2019 - GDI - Lesson 4

Including arbitrary indexed fields with your request.

## Basic token
Create a token with a custom name.

    curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http -d name=indexed_fields_token -d token=55db8431-89c8-4941-9b70-c44bafd56cf7

## Send events to this token with custom indexed fields

    curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk 55db8431-89c8-4941-9b70-c44bafd56cf7' -d '{"event":"Hello, Basic Token World!", "fields": {"a_custom_field": "a_custom_value", "another_custom_field": "another_custom_value"}, "sourcetype": "mysourcetype"}'

Check the results in the Splunk search
    
    index=main a_custom_field="*"