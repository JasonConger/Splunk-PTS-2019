# Splunk PTS 2019 - Dashboards - Lesson 5

## Table Pivot

A [DataTemplateView](https://docs.splunk.com/DocumentationStatic/WebFramework/1.4/compref_datatemplate.html) can be used to render search results any way you want.  This example takes table results and turns them into a list.

## Clean up from Lesson 4

* Edit the dashboard
* Delete the "Table without tool tips" panel
* Save

## Add a Placeholder for the DataViewTemplate

* Edit the dashboard source
* Paste the HTML code below between `</table>` and `</panel>`

> Existing

```xml
    <panel>
      <table>
        <title>IP Address Details</title>
        <search base="map_search"></search>
      </table>
```

> New

```xml
      <html>
        <h3 class="dashboard-element-title">IP Address Details (table pivot)</h3>
        <div id="list-view"/>
      </html>
```

> Existing

```xml
    </panel>
```

* Save

## Create the DataTemplateView JavaScript
* Create `$SPLUNK_HOME/etc/apps/pts/appserver/static/table2list.js`
* Paste the following code:

```javascript
require([
    'underscore',
    'jquery',
    'splunkjs/mvc',
    'splunkjs/mvc/dataview',
    'splunkjs/mvc/simplexml/ready!'
], function(_, $, mvc, DataView) {
	
	var templateString = "\
<%\
for(var i=0, l=results.length; i<l; i++) { \
	var line=results[i]; %> \
	<table id='list-view-template' class='table table-bordered'><tbody> \
	\
	<% for(var key in line) {\
		var attrName = key;\
		var attrValue = line[key];\
		%> \
		<tr>\
			<td width='100px' style='text-align: right'><%= attrName %>:</td>\
			<td><%= attrValue %></td>\
		</tr>\
	<% } %> \
    \
	</tbody></table> \
<% }%> \
";
	
	var dtview = new DataView({
		id: "dtview",
		managerid: "map_search",
		template: templateString,
		el: $("#list-view")
	}).render();

});
```
* Save

> **Note**: The DavaView uses the template string to render the data.  The template string can be whatever you want.  This example uses [Underscore.js](https://underscorejs.org/) to programmatically create the string.


## Wire things up
* Edit the dashboard source
* Add a reference to the JavaScript in the `<form>` tag like so:

```xml
<form stylesheet="tooltip.css" script="tooltip.js,table2list.js">
```
* Save
* Refresh the dashboard
* The table is now also a list

> **Note**: notice you can chain multiple JavaScript file references together using a comma.

![list result](https://github.com/JasonConger/Splunk-PTS-2019/raw/master/images/table_list.png "list result")
