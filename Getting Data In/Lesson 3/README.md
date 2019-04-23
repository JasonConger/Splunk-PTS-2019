# Splunk PTS 2019 - GDI - Lesson 3

Create a HEC token via REST.

## Basic token
Create a token with a custom name.

    curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http -d name=basic_token 

Test the token.

    curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk <token>' -d '{"event":"Hello, Basic Token World!"}'

## Token with specific params
We will create a token with a cusotm name that is disabled on creation with a description.

    curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http -d name=enabled_token -d description="This token was created programatically" -d disabled=1

We can enable this token in a subsequent request.

    curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http/enabled_token -d disabled=0

Test the token. (After enabling)

    curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk <token>' -d '{"event":"Hello, Specific Token World!"}'

Need to open up Pandora's box to see how this works. Look at all these parameters we can send with our Create/Edit requests! http://dev.splunk.com/view/event-collector/SP-CAAAE7C#editanhttpeventcollectortokenusingcurl

We can set up default and allowed indexes, sourcetypes, sources, etc. using these parameters

## Custom GUID token (undocumented)
Let's generate a custom GUID, which we can send with our request to create the token with the provided token.

Copy paste a GUID from here: https://www.guidgenerator.com/online-guid-generator.aspx

    curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http -d name=custom_guid_value_token -d token={COPY PASTE GUID HERE}

Test the token.

    curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk <token>' -d '{"event":"Hello, Custom GUID World!"}'

## (Bonus) Custom value token?!
Do we validate for a GUID? No, but custom values are NOT recommended/supported.

	curl -k -u admin:password https://localhost:8089/servicesNS/admin/splunk_httpinput/data/inputs/http -d name=custom_value_token -d token=whateveriwant

Test the token.

    curl -k https://localhost:8088/services/collector -H 'Authorization: Splunk whateveriwant' -d '{"event":"Hello, Custom Token World!"}'
