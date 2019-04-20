# Splunk PTS 2019 - Dashboards - Lesson 1
Developer tips

## Useful Settings for Splunk Developers

Modify (or create) `$SPLUNK_HOME/etc/system/local/web.conf`

```
[settings]
minify_js = False
minify_css = False
js_no_cache = True
cacheEntriesLimit = 0
cacheBytesLimit = 0
enableWebDebug = True
```

## Disable Caching in your browser debug capabilities
Example below from the Google Chrome browser:

![browser cache](https://github.com/JasonConger/Splunk-PTS-2019/raw/master/images/browser_cache.png "browser cache")

## JavaScript - force a break point when debugging

```javascript
function reduce_links() {

	let reduced_links = [], temp_links = {}, temp_elb_links = {};
	
		for (let index = 0; index < links.length; ++index) {
			let rel = links[index];
			
			debugger;
```