package org.rickosborne.as3
{
	import flash.events.Event;
	
	public class RestApiEvent extends Event
	{
		public static const RESTAPI_COMPLETE:String = "restapi_complete";
		public static const RESTAPI_IOERROR :String = "restapi_ioerror";
		private var _data:String = null;
		private var _requestId:String = null;
		
		public function RestApiEvent(type:String, data:String = null, requestId:String = null)
		{
			super(type, false, false);
			this._data = data;
			this._requestId = requestId;
		}
		
		public function get data():String { return this._data; }
		public function get requestId():String { return this._requestId; }
	}
}