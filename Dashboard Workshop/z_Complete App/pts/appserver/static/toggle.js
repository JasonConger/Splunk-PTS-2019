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
					"height": "auto",
					"overflow": "visible"
				});
			}
			else
			{
				button.attr("src", "/static/app/pts/expand.png");
				target.css({
					"height": "0px",
					"overflow": "hidden"
				});
			}
		}
			
		// Setup the click handlers for the toggle buttons
		$("#imgToggle1").click(function(){
			toggle($(this), $("#tooltip_row"));
		});

    });
});