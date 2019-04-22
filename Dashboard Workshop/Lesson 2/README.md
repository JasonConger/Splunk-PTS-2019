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
* Apply

![new Splunk input](https://github.com/JasonConger/Splunk-PTS-2019/raw/master/images/Textbox.png "new Splunk input")

## Add a Submit Button
* Add Input > Submit

## Create Global Search
* Click the "Source" button next to "Edit Dashboard"
* Paste the following after `</fieldset>`

```xml
<search id="map_search">
  <query>
    | makeresults | eval ipaddr="$ipaddr$" | iplocation ipaddr
  </query>
</search>
```

## Add a Row, Table Panel, and Map Panel
Paste the following after `</search>`

```xml
<row>
  <panel>
    <table>
      <title>IP Address Details</title>
        <search base="map_search"></search>
    </table>
  </panel>
    
  <panel>
    <map>
      <title>The map shows up if geostats can determine lat and lon</title>
      <search base="map_search">
        <query>geostats count by ipaddr</query>
      </search>
    </map>
  </panel>
</row>
```

## Test
If you have not already saved the form, save it now.

* IP Address = 54.69.58.243 > Submit

You should see data in the table and the map.

* IP Address = 127.0.0.1 > Sumbit

You should see data in the table, but not the map.

## Conditionally show the map
Showing an empty map may be confusing, so we will hide if if we cannot map it.

* Edit the dashboard
* Add the following between `</query>` and `</search>`

```xml
<progress>
  <condition match='$result.lat$!=""'>
    <set token="show_map">true</set>
  </condition>
  <condition>
    <unset token="show_map"></unset>
  </condition>
</progress>
```

* Add `depends="$show_map$"` to the map panel.  Like this:

```xml
<panel depends="$show_map$">
  <map>
```

* Test again.  This time, the map should not be visible for the 127.0.0.1 address.