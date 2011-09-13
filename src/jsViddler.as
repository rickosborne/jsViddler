package
{
	import avmplus.describeType;
	
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.utils.describeType;
	
	import org.rickosborne.as3.ViddlerApi;
	
	[SWF(width="400", height="300", backgroundColor="#ffffff", frameRate="24")]
	
	public class jsViddler extends Sprite
	{
		
		private var api:ViddlerApi;
		private var logText:TextField;
		
		public function jsViddler() {
			trace("jsViddler");
			api = new ViddlerApi();
			logText = new TextField();
			addChild(logText);
			ExternalInterface.addCallback("viddlerApi2", api2);
			registerExternalCallbacks(api);
		}
		
		private function registerExternalCallbacks(o:Object):void {
			var meta:XML = flash.utils.describeType(o);
			var typeName:String = meta.attribute("name");
			trace(typeName);
			//trace(meta["type"]);
			for each (var method:XML in meta..method.(@declaredBy == typeName)) {
				var methodName:String = method.attribute("name");
				trace("method: " + methodName);
				// (function(methodName:String):Function{return function(args:Object):void{api2(methodName, args);}})(methodName)
				ExternalInterface.addCallback(methodName, o[methodName]);
			}
			trace("callbacks registered");
		}
		
		public function api2(methodName:String, arguments:Object):void {
			trace("api2('" + methodName + "')");
			logText.appendText("available: " + ExternalInterface.available + "\n");
			if (!ExternalInterface.available)
				return;
			
		}
		
		
	}
}