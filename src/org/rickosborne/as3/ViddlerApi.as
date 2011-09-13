package org.rickosborne.as3 {
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	public class ViddlerApi extends JsonRestApi {
		
		private var key:String = null;
		private var callback:String = null; 
		private static const API_V2_URL:String       = "http://api.viddler.com/api/v2/";
		private static const REQUEST_FORMAT:String   = ".json";
		private static const METHOD_GET:String       = "GET";
		private static const METHOD_POST:String      = "POST";
		private static const API_KEY:String          = "";
		public  static const CALLBACK_DEFAULT:String = "onViddler";

		private static const VIDDLER_API_ECHO:String         = "viddler.api.echo";
		private static const VIDDLER_API_GETINFO:String      = "viddler.api.getInfo";
		private static const VIDDLER_API_GETOPTIONS:String   = "viddler.encoding.getOptions";
		private static const VIDDLER_API_GETENCSTATUS:String = "viddler.encoding.getStatus";
		private static const VIDDLER_API_GETPROFILE:String   = "viddler.users.getProfile";
		private static const VIDDLER_API_GETUSERVIDEOS:String = "viddler.videos.getByUser";

		private function usingKey():Boolean { return ((this.key != null) && (this.key.length > 0)); }
		
		public function ViddlerApi(key:String = null) {
			this.key = key ? key : API_KEY;
			super();
			this.addEventListener(JsonRestApiEvent.JSONRESTAPI_COMPLETE, onJsonRestApiComplete);
		}
		
		private function onJsonRestApiComplete(e:JsonRestApiEvent):void {
			trace("on" + e.type + ":" + e.requestId);
			if ((this.callback != null) && ExternalInterface.available) {
				ExternalInterface.call(this.callback, e.requestId, e.data);
				trace("response:" + e.requestId + ":" + e.data);
			}
		}
		
		public function setCallback(callbackName:String):void { this.callback = callbackName; }
		public function setKey(key:String):void { this.key = key; }
		
		public function jsonApiRequest(callName:String, callMethod:String = "GET", callArguments:Object = null, requestId:String = null):void {
			if (callArguments == null)
				callArguments = {};
			if (!("key" in callArguments))
				callArguments["key"] = this.key;
			trace("jsonApiRequest:" + callName + ":" + callMethod + ":" + requestId);
			super.jsonRequest(API_V2_URL + callName + REQUEST_FORMAT, callMethod, callArguments, requestId); 
		}
		
		public function echo(message:String, requestId:String = null):void { jsonApiRequest(VIDDLER_API_ECHO, METHOD_GET, { message: message, key: this.key }, requestId); }
		public function getInfo(requestId:String = null):void { jsonApiRequest(VIDDLER_API_GETINFO, METHOD_GET, { key: this.key }, requestId); }
		public function getOptions(requestId:String = null):void { jsonApiRequest(VIDDLER_API_GETOPTIONS, METHOD_GET, { key: this.key }, requestId); }
		public function getEncodingStatus(requestId:String = null):void { jsonApiRequest(VIDDLER_API_GETENCSTATUS, METHOD_GET, { key: this.key }, requestId); }
		public function getUserProfile(user:String, requestId:String = null):void { jsonApiRequest(VIDDLER_API_GETPROFILE, METHOD_GET, { user: user, key: this.key }, requestId); }

		public function getUserVideos(user:String, page:int = 0, per_page:int = 0, status:String = null, sort:String = null, tags:String = null, requestId:String = null):void {
			var opts:Object = { user: user, key: this.key };
			if (page     > 0)      { opts["page"]     = page; }
			if (per_page > 0)      { opts["per_page"] = per_page; }
			if (status   !== null) { opts["status"]   = status; }
			if (sort     !== null) { opts["sort"]     = sort; }
			if (tags     !== null) { opts["tags"]     = tags; }
			jsonApiRequest(VIDDLER_API_GETPROFILE, METHOD_GET, opts, requestId);
		}
		
	}
}