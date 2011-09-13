package org.rickosborne.as3 {

	import flash.events.Event;

	public class JsonRestApi extends RestApi {
		
		public function JsonRestApi() {
			super();
			this.addEventListener(RestApiEvent.RESTAPI_COMPLETE, onRestApiComplete);
		}
		
		private function onRestApiComplete(e:RestApiEvent):void {
			this.dispatchEvent(new JsonRestApiEvent(JsonRestApiEvent.JSONRESTAPI_COMPLETE, e.data, e.requestId));
		}
		
		protected function jsonRequest(apiUrl:String, apiMethod:String = "GET", apiArguments:Object = null, requestId:String = null):void {
			super.request(apiUrl, apiMethod, apiArguments, requestId);
		}
		
	}
}