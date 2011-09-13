package org.rickosborne.as3
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class RestApiURLLoader extends URLLoader
	{
		private var _requestId:String = null;
		
		public function RestApiURLLoader(requestId:String = null)
		{
			this._requestId = requestId;
			super(null);
		}
		
		public function get requestId():String { return this._requestId; }
	}
}