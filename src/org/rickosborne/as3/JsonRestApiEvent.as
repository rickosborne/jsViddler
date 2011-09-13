package org.rickosborne.as3
{
	import flash.events.Event;
	
	public class JsonRestApiEvent extends Event
	{
		public static const JSONRESTAPI_COMPLETE:String = "jsonrestapi_complete";
		private var _data:String = null;
		private var _requestId:String = null;
		
		public function JsonRestApiEvent(type:String, data:String, requestId:String = null)
		{
			super(type, false, false);
			this._data = data;
			this._requestId = requestId;
		}
		
		public function get data():Object { return this._data; }
		public function get requestId():Object { return this._requestId; }
	}
}