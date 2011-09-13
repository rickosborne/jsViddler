(function(){
	var alreadyLoaded = false; 
   	var cl = function() { if (console && console.log) console.log.apply(console, arguments); };
   	var openRequests = {};
   	var lastRequest = 0;
   	var viddler;
   	var api = function(callName, callMethod, callArguments, callback) {
   		// cl("[jsViddler:api:]");
   		var requestId = "" + (++lastRequest);
   		openRequests[requestId] = callback;
   		viddler.jsonApiRequest(callName, callMethod, callArguments, requestId);
   	};
	window.onViddler = function(requestId, data){
		if (!(requestId in openRequests)) {
			cl("[jsViddler:callback] Got an unexpected response:", requestId, data);
			return;
		}
		var callback = openRequests[requestId];
		delete openRequests[requestId];
		if (callback) {
			var r = JSON.parse(data);
			// cl("[jsViddler:callback]", r);
			callback(r);
		}
	};
	var onReady = function() {
		if (alreadyLoaded) return;
		alreadyLoaded = true;
    	viddler = document.getElementById("jsViddler");
    	setTimeout(function(){
			viddler.setCallback("onViddler");
		}, 1000);
	};
	document.addEventListener("DOMContentLoaded", onReady, false);
	window.addEventListener("load", onReady, false);
	window.jsViddler = {
		setCallback: function(cb) { window.onViddler = cb; },
		openRequests: function() { return openRequests; },
		setKey: function(key) { viddler.setKey(key); },
		echo: function(m, cb) { api("viddler.api.echo", "GET", { message: m }, function(r) { cb(r.echo_response.message); }); },
		getUserVideos: function(u, cb) { api("viddler.videos.getByUser", "GET", { user: u }, function(r) { cb(r.list_result); }); } 
	};
})();
