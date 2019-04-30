# Splunk PTS 2019 - Dashboards - Lesson 4

## Bootstrap Tooltip in a Table
[https://getbootstrap.com/2.3.2/javascript.html#tooltips](https://getbootstrap.com/2.3.2/javascript.html#tooltips)

## Simple XML
* Edit the dashboard from Lesson 1
* Select source view
* Add a new global search

```xml
<search id="main">
    <query>index=_internal |
        stats count by index host source sourcetype |
        eval really_long_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer elit diam, efficitur a sem at, varius euismod risus. Nullam vitae consequat orci. Mauris vulputate diam et lectus laoreet, ac sodales enim auctor. Nulla facilisi. Donec dictum varius augue ut finibus. Ut sed dapibus sapien, vitae tempor mi. Vestibulum mollis metus sit amet sapien semper sollicitudin sed ut ligula. Ut quam risus, cursus non elit id, luctus consectetur lorem. Donec non risus risus. Etiam a massa tellus. Donec sit amet vulputate urna. Mauris at semper nisi, et semper velit. Aenean quis diam leo.  Proin augue lacus, tincidunt id consectetur id, facilisis a orci. Nunc condimentum elementum lectus at consectetur. Curabitur sit amet mi nunc. Sed sollicitudin consectetur bibendum. Nullam ullamcorper mi ut tincidunt aliquet. Phasellus rutrum magna ante, non laoreet risus fringilla ac. Maecenas tempor lectus elit, eu laoreet massa vehicula a. Maecenas vel pharetra eros. Fusce vulputate pharetra sagittis."</query>
        <earliest>-24h@h</earliest>
        <latest>now</latest>
  </search>
```

* Add 2 rows

```xml
<row>
    <panel>
      <table>
        <title>Table without tool tips</title>
        <search base="main">
          <query>table index  sourcetype really_long_text source | rename really_long_text AS "Message"</query>
        </search>
        <option name="count">5</option>
      </table>
    </panel>
  </row>
  <row>
    <panel>
      <table id="tblTooltip">
        <title>Table with tool tips</title>
        <search base="main">
          <query>table index  sourcetype really_long_text source | rename really_long_text AS "Message"</query>
        </search>
      </table>
    </panel>
  </row>
```

* Save

## JavaScript
* Create a file named `autodiscover.js` in `$SPLUNK_HOME/etc/apps/pts/appserver/static`

copypasta

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
    });
});
```
* Create a file named `tooltip.js` in `$SPLUNK_HOME/etc/apps/pts/appserver/static`

copypasta

```javascript
require([
    'underscore',
    'jquery',
    'splunkjs/mvc',
    'splunkjs/mvc/tableview',
    'splunkjs/mvc/simplexml/ready!'
], function(_, $, mvc, TableView) {
    
    var CustomTooltipRenderer = TableView.BaseCellRenderer.extend({
        canRender: function(cell) {
            return cell.field === 'Message';
        },
        render: function($td, cell) {
            
            var message = cell.value;
            var tip = cell.value;
            
            if(message.length > 48) { message = message.substring(0,47) + "..." }
            
            $td.html(_.template('<a href="#" data-toggle="tooltip" data-container="body" data-placement="top" title="<%- tip%>"><%- message%></a>', {
                tip: tip,
                message: message
            }));
            
            // This line wires up the Bootstrap tooltip to the cell markup
            $td.children('[data-toggle="tooltip"]').tooltip();
        }
    });
    
    mvc.Components.get('tblTooltip').getVisualization(function(tableView) {
        
        // Register custom cell renderer
        tableView.table.addCellRenderer(new CustomTooltipRenderer());

        // Force the table to re-render
        tableView.table.render();
    });
    
});
```
* Create a file named `tooltip.css` in `$SPLUNK_HOME/etc/apps/pts/appserver/static`

copypasta

```css
.tooltip-inner {
    max-width: 800px;
    text-align: left;
    font-size: 14px;
    font-weight: normal;
}
```

## Wire up the Simple XML to the JavaScript

* Refresh Splunk after adding the .js and .css files
  * `$SPLUNK_HOME/bin/splunk restart`
* Edit the Simple XML dashboard
* Modify the `<form>` tag like so:

`<form stylesheet="tooltip.css" script="tooltip.js">`

* Save
* Refresh your browser
* Hover over the Message field in the second table
