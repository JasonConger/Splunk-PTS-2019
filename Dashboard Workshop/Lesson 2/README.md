# Splunk PTS 2019 - Dashboards - Lesson 2
Conditionally show a dashboard panel

## Create a Splunk App
* From Splunk Web, click the gear icon next to apps

![new Splunk app](https://github.com/JasonConger/Splunk-PTS-2019/raw/master/images/SplunkNewApp.png "new Splunk app")

* Click the "Create app" button
  * Name = PTS
  * Folder name = pts
  * Version = 1.0.0
  * Visible = Yes
  * Author = your name
  * Description = PTS example
  * Template = barebones
* Click Save
* Click the "Launch app" link for the app just created
* Click the "Dashboards" navigation menu link
* Create New Dashboard
  * Title = PTS Example
  * ID = pts_example
  * Description = PTS Example Dashboard
  * Permissions = Shared in App
* Create Dashboard

## Add an Input
* Add Input > Text
  * Label = IP Address:
  * Token = ipaddr

![new Splunk input](https://github.com/JasonConger/Splunk-PTS-2019/raw/master/images/Textbox.png "new Splunk input")