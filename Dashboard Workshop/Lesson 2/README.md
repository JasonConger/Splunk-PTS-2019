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

### Add an Input
* Add Input > Text
  * Label = IP Address:
  * Token = ipaddr
  * Default = 54.69.58.243
* Apply

![new Splunk input](https://github.com/JasonConger/Splunk-PTS-2019/raw/master/images/Textbox.png "new Splunk input")

### Add a Submit Button
* Add Input > Submit

### Set the Dashboard to Autorun
![autorun](https://github.com/JasonConger/Splunk-PTS-2019/raw/master/images/autorun.png "autorun")

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

> **Note**: the search takes the value of the field and runs iplocation to resolve City, Country, Region, lat, and lon

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

* If you have not already saved the form, save it now
* You should see data in the table and the map
* Change the IP Address to 127.0.0.1 and click Sumbit
* You should see data in the table, but not the map

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

> **Note**: the above is an event handler for the search.  The actual value of the token does not make a difference.  The only condition we test is whether the token is set or not.

### Complete Example
[https://github.com/JasonConger/Splunk-PTS-2019/blob/master/Dashboard%20Workshop/Lesson%202/pts/local/data/ui/views/pts_example.xml](https://github.com/JasonConger/Splunk-PTS-2019/blob/master/Dashboard%20Workshop/Lesson%202/pts/local/data/ui/views/pts_example.xml)