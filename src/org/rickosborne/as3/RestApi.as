package org.rickosborne.as3 {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	public class RestApi extends EventDispatcher {
		
		protected function request(apiUrl:String, apiMethod:String = "GET", apiArguments:Object = null, requestId:String = null):void {
			var req:URLRequest = new URLRequest(apiUrl);
			if (apiArguments != null) {
				var uv:URLVariables = new URLVariables();
				for (var keyName:String in apiArguments) {
					trace(keyName + "=" + apiArguments[keyName]);
					uv[keyName] = apiArguments[keyName];
				}
				trace("URLVariables");
				trace(uv);
				req.data = uv;
			}
			req.method = apiMethod;
			var loader:RestApiURLLoader = new RestApiURLLoader(requestId);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onComplete);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(req);	
		}
		
		private function onComplete(e:Event):void {
			var l:RestApiURLLoader = (e.target as RestApiURLLoader);
			this.dispatchEvent(new RestApiEvent(RestApiEvent.RESTAPI_COMPLETE, l.data, l.requestId));
		}
		
	}
}