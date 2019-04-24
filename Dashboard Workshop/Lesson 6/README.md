# Splunk PTS 2019 - Dashboards - Lesson 6

## Toggle Element Visibility
In this lesson, we will add an interactive toggle button to the dashboard to show/hide the table.

## Set up the Simple XML
* Edit the dashboard source

* Add the following HTML:

> Existing

```xml
        <div id="list-view"/>
      </html>
```

> New

```xml
      <html>
	      <div style="float: right">
		      Show/hide the table below  <img id="imgToggle1" class="toggle" title="Show/hide table below" src="/static/app/pts/expand.png"/>
	      </div>
	    </html>
```


* Add `id=tooltip_row` to the row containing the tooltip table like so:

```xml
<row id="tooltip_row">
    <panel>
      <table id="tblTooltip">
        <title>Table with tool tips</title>
```

* Save

## Create the Toggle JavaScript

* Create `$SPLUNK_HOME/etc/apps/pts/appserver/static/toggle.js`
* Paste the following code:

```javascript
require.config({
    paths: {
        "app": "../app"
    }
});
require(['splunkjs/mvc/simplexml/ready!'], function(){
    require(['splunkjs/ready!'], function(){
        // The splunkjs/ready loader script will automatically instantiate all elements
        // declared in the dashboard's HTML.
	
		// ************************************************************
		// This fuction toggles the visibility and height of an element
		// and is reusable.
		// ************************************************************
		function toggle(button, target) {
			
			if(target.css("height") == "0px" ) {
				button.attr("src", "/static/app/pts/collapse.png");
				target.css({
					"height": "auto"
				});
			}
			else
			{
				button.attr("src", "/static/app/pts/expand.png");
				target.css({
					"height": "0px"
				});
			}
		}
			
		// Setup the click handlers for the toggle buttons
		$("#imgToggle1").click(function(){
			toggle($(this), $("#tooltip_row"));
		});

    });
});
```
* Save

## Create the Toggle CSS

* Create `$SPLUNK_HOME/etc/apps/pts/appserver/static/toggle.css`
* Paste the following code:

```css
#tooltip_row {
    /*visibility: hidden;*/
    height: 0px;
    overflow: hidden;
}
```

## Upload the Toggle Images

* Put these in `$SPLUNK_HOME/etc/apps/appserver/static`

![collapse](https://github.com/JasonConger/Splunk-PTS-2019/raw/master/images/collapse.png "collapse")

![expand](https://github.com/JasonConger/Splunk-PTS-2019/raw/master/images/expand.png "expand")

## Wire things up
* Edit the dashboard source
* Add a reference to the JavaScript and CSS in the `<form>` tag like so:

```xml
<form stylesheet="tooltip.css,toggle.css" script="tooltip.js,table2list.js,toggle.js">
```
* Save
* Refresh the dashboard