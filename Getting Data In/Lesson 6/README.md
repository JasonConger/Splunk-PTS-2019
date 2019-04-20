# Splunk PTS 2019 - GDI - Lesson 6

Use Splunk Add-on Builder to create a modular input that queries a REST API using OAuth

## Get the Splunk Add-on Builder
[https://splunkbase.splunk.com/app/2962/](https://splunkbase.splunk.com/app/2962/)

## Create an Add-on
* Launch Splunk Add-on Builder from Splunk Web
* Click the "New Add-on" button
  * Add-on Name = PTS
* Click Create

## Create a Data Input
* Click the "Configure Data Collection" menu item
* Click the "New Input" button
* Select "Modular input using my Python Code"
  * Data Input Properties
    * Source type name = pts:rest
    * Input display name = PTS REST
    * Input name = pts_rest
    * Description = leave blank
    * Collection interval = 30 seconds
  * Data Input Parameters
    * Drag and drop a text box to the form
      * Display label = Tenant ID
      * Internal name = tenant_id
      * Default display text = Tenant ID
      * Default value = leave blank
      * Help text = leave blank
      * Required = checked
    * Drag and drop a text box to the form
      * Display label = Subscription ID
      * Internal name = subscription_id
      * Default display text = Subscription ID
      * Default value = leave blank
      * Help text = leave blank
      * Required = checked
    * Drag and drop a Global Account dropdown on the form
    * Add-on Setup Parameters
      * Global account settings = checked
    * Click the "Next" button
    * Delete all the current code and paste the following skeleton:
 
```python
import os
import sys
import time
import datetime
import json
import utils.auth as rauth
import utils.utils as utils
     
def validate_input(helper, definition):
	pass
	
def collect_events(helper, ew):
	pass
```

## Create the OAuth Helper
* Create the following directory:

    $SPLUNK_HOME/etc/apps/TA-pts/bin/utils
    
* Create an empty `__init__.py` file in the above directory.
  * Note: those are 2 underscores on either side of the init in the file name above (_ _ init _ _ . py)

* Create a file named `auth.py` in the utils directory
* Paste the following code:

```python
# encoding = utf-8
import sys
import json
import requests

def get_access_token(client_id, client_secret, tenant_id):
    endpoint = "https://login.windows.net/%s/oauth2/token" % tenant_id
    payload = {
        'resource': 'https://management.azure.com/',
        'grant_type': 'client_credentials',
        'client_id': client_id,
        'client_secret': client_secret
    }
    try:
        response = requests.post(endpoint, data=payload).json()
        return response['access_token']
    except Exception, e:
        raise e
```

## Create an Event Retrieval Helper

* Ceate a file named `utils.py` in the utils directory
* Paste the following code:

```python
# encoding = utf-8
import sys
import json
import requests

def get_items(helper, access_token, url, items=[]):
    header = {'Authorization':'Bearer ' + access_token}

    try:
        r = requests.get(url, headers=header)
        r.raise_for_status()
        response_json = json.loads(r.content)
        items += response_json['value']

        if '@odata.nextLink' in response_json:
            helper.log_debug("Next URL (@odata.nextLink): %s" % response_json['@odata.nextLink'])
            get_items(helper, access_token, response_json['@odata.nextLink'], items)
        
    except Exception, e:
        raise e

    return items
```

## Test

* Tenant ID = 
* Subscription ID = 
* Add-on Setup Parameters
  * Username (app id) = 
  * Password (app key) = 

Paste the following for `collect_events`:

```python
def collect_events(helper, ew):
    global_account = helper.get_arg("global_account")
    client_id = global_account["username"]
    client_secret = global_account["password"]
    subscription_id = helper.get_arg("subscription_id")
    tenant_id = helper.get_arg("tenant_id")
    resource_group_api_version = "2018-05-01"
    
    access_token = rauth.get_access_token(client_id, client_secret, tenant_id)
    
    if(access_token):
        
        helper.log_debug("Collecting resource group data.")
        url = "https://management.azure.com/subscriptions/%s/resourcegroups?api-version=%s" % (subscription_id, resource_group_api_version)
        resource_groups = utils.get_items(helper, access_token, url)
        for resource_group in resource_groups:
            event = helper.new_event(
                data=json.dumps(resource_group),
                source=helper.get_input_type(), 
                index=helper.get_output_index(),
                sourcetype=helper.get_sourcetype())
            ew.write_event(event)

    else:
        raise RuntimeError("Unable to obtain access token. Please check the Client ID, Client Secret, and Tenant ID")
```

* Click the "Test" button.
* Click the "Finish" button. 