# Splunk PTS 2019 - GDI - Lesson 5

Pro Tip - using ngrok to test external to internal HEC

## Download ngrok
[https://ngrok.com](https://ngrok.com)

## Launch ngrok
    ngrok http 8088

Result

![ngrok result](https://github.com/JasonConger/Splunk-PTS-2019/raw/master/images/ngrok.png "ngrok result")

## Test HEC from an outside machine
      curl -v -k "http://a8046db5.ngrok.io/services/collector/raw?channel=<guid>" -H "Authorization: Splunk <token>" -d 'data via ngrok'
