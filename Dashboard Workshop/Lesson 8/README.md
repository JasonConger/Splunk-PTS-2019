# Splunk PTS 2019 - Dashboards - Lesson 8

## Putting it all together
In this lesson, we will listen for token changes in JavaScript and pop up a modal dialog with a chart in it.

## Set up the Simple XML
* Edit the form source

### Modify the query for the `id="main"` search
We need to add a "Detail" field.

> Before

...```stats count by index host source sourcetype | ```...

> After

...```stats count by index host source sourcetype | eval Detail = "" |```...

### Modify the query for the tooltip table
We need to add the "Detail" field to the `table` SPL

> Before

...```<query>table index  sourcetype really_long_text source | rename really_long_text AS "Message"</query>```...

> After

...```<query>table index  sourcetype really_long_text source Detail | rename really_long_text AS "Message"</query>```...

### Add a new global search
This will be used for the chart in the modal popup.

```xml
<search id="chart_search">
    <query>
      index=_internal sourcetype=$chart_sourcetype$ | timechart count
    </query>
    <earliest>-4h</earliest>
    <latest>now</latest>
</search>
```

### Add a drilldown to the tooltip table between `</search>` and `</table>` to set a token
The value of the token will be the sourcetype of the row clicked.

```xml
<option name="drilldown">cell</option>
<drilldown>
  <set token="chart_sourcetype">$row.sourcetype$</set>
</drilldown>
```

### Add the following XML before the closing `</form>` tag to use with the modal chart:

```xml
<row>
  <panel>
    <html>

<!-- Modal Chart -->
<div class="modal fade" id="modalChart" tabindex="-1" role="dialog" aria-labelledby="modalChartLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalChartLabel">Details: $chart_sourcetype$</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"/>
        </button>
      </div>
      <div class="modal-body">
        <div id="chartDetail"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

    </html>
  </panel>
</row>
```
* Save

## Create the JavaScript

* Create `$SPLUNK_HOME/etc/apps/pts/appserver/static/modal_chart.js`
* Paste the following code:

```javascript
require([
    'underscore',
    'jquery',
    'splunkjs/mvc',
	'splunkjs/mvc/tableview',
	'splunkjs/mvc/chartview',
    'splunkjs/mvc/simplexml/ready!'
], function(_, $, mvc, TableView, ChartView) {


	var CustomIconRenderer = TableView.BaseCellRenderer.extend({
		canRender: function(cell) {
			return cell.field === 'Detail';
		},
		render: function($td, cell) {
			$td.html(('<i class="icon-chart-area" style="font-size:2em" />'));
		}
	});

	mvc.Components.get('tblTooltip').getVisualization(function(tableView) {
        
        // Register custom cell renderer
        tableView.table.addCellRenderer(new CustomIconRenderer());

        // Force the table to re-render
        tableView.table.render();
	});
	
	var areaChart = new ChartView({id: "chart-view"});
	
	// Listen for token changes
	var tokens = mvc.Components.get("default");
	tokens.on("change:chart_sourcetype", function(model, value, options) {

		$('#modalChart').modal();
		
		mvc.Components.get("chart-view").remove();
		var areaChart = new ChartView({
			id: "chart-view",
			managerid: "chart_search",
			type: "area",
			"charting.chart.nullValueMode": "connect",
			el: $("#chartDetail")
		}).render();

	});
});
```
* Save

> **Note**: this JavaScript does 2 main things:

1. Creates an icon in the table.  Notice that the icon came from the Splunk style guide.
2. Listens for token changes (the table drill down sets a token) via `tokens.on("change`...  When the token does change, the Bootstrap modal popup is displayed

## Wire things up
* Edit the form source
* Add a reference to the JavaScript and CSS in the `<form>` tag like so:

```<form stylesheet="tooltip.css,toggle.css" script="tooltip.js,table2list.js,toggle.js,set_input_types.js,modal_chart.js">```

* Save
* Refresh
* Expand the table
* Click one of the chart icons
  * It may be helpful to choose a row that has a splunkd sourcetype since the chart that renders is a real time 5-minute window chart, and the splunkd sourcetype will most likely have data available in that time range. 
* A modal should pop up with a chart
