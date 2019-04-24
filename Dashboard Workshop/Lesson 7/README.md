# Splunk PTS 2019 - Dashboards - Lesson 7

## Control Textbox Input Type
HTML `<input>` tags can have different types.  HTML5 introduces some useful types for Splunk like date, number, and range.  This lesson walks through applying these types to `<form>` inputs.

## Add Text Inputs to the Form
* Edit the form source
* Add the following `<input>` markup:

> Existing

```xml
<fieldset submitButton="true" autoRun="true">
    <input type="text" token="ipaddr">
      <label>IP Address:</label>
      <initialValue>204.107.141.22</initialValue>
    </input>
```
> New

```xml    
    <input type="text" token="numbers" id="numbers_only" searchWhenChanged="true">
      <label>Numbers only</label>
      <default>1</default>
    </input>
    
    <input type="text" token="numbers_0_100" id="numbers_0_100_step10" searchWhenChanged="true">
      <label>Numbers 0-100 step=10</label>
      <default>0</default>
    </input>
    
    <input type="text" token="date" id="date" searchWhenChanged="true">
      <label>Date</label>
    </input>
    
    <input type="text" token="date_restrictions" id="date_restrictions" searchWhenChanged="true">
      <label>Date after 2018-08-01</label>
    </input>
    
    <input type="text" token="range" id="range" searchWhenChanged="true">
      <label>Range (0-10)</label>
      <default>5</default>
    </input>
```

* Save

## Create the JavaScript to Assign Attributes to the `<input>` Elements

* Create `$SPLUNK_HOME/etc/apps/pts/appserver/static/set_input_types.js`
* Paste the following code:

```javascript
require(["jquery", "splunkjs/mvc/simplexml/ready!"], function($) {
	
	$("[id^=numbers_only]")
		.find("input")
		.attr('type','number')

		
	$("[id^=numbers_0_100_step10]")
		.find("input")
		.attr('type','number')
		.attr('min','0')
		.attr('max','100')
		.attr('step','10')
		
	$("[id^=date]")
		.find("input")
		.attr('type','date')
		
	$("[id^=date_restrictions]")
		.find("input")
		.attr('type','date')
		.attr('min','2018-08-02')
		
	$("[id^=range]")
		.find("input")
		.attr('type','range')
		.attr('min','0')
		.attr('max','10')

});
```

> **Note**: the JavaScript finds the element by ID and then adds a HTML5 attribute.

* Save

## Wire things up
* Edit the form source
* Add a reference to the JavaScript and CSS in the `<form>` tag like so:

```xml
<form stylesheet="tooltip.css,toggle.css" script="tooltip.js,table2list.js,toggle.js,set_input_types.js">
```
* Save
* Refresh the dashboard
* Try out the input types