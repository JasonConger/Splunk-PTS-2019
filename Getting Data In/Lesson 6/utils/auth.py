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