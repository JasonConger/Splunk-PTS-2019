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