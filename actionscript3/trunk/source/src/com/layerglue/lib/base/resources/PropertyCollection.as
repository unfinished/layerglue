package com.layerglue.lib.base.resources
{
	import com.layerglue.lib.base.collections.HashMap;
	import com.layerglue.lib.base.events.EventListener;
	import com.layerglue.lib.base.events.PropertyCollectionEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class PropertyCollection extends EventDispatcher
	{
		private var _map:HashMap;
		private var _primaryLoader:URLLoader;
		private var _primaryLoaderCompleteListener:EventListener;
		
		public function PropertyCollection()
		{
			super();
		}
		
		/**
		 * Loads a remote XML file, deserializing it on completion.
		 */
		public function load(request:URLRequest):void
		{
			destroyPrimaryLoader();
			
			_primaryLoader = new URLLoader();
			_primaryLoaderCompleteListener = new EventListener(_primaryLoader, Event.COMPLETE, primaryLoaderCompleteHandler);
			_primaryLoader.load(request);
		}
		
		private function destroyPrimaryLoader():void
		{
			if(_primaryLoader)
			{
				_primaryLoaderCompleteListener.destroy();
				_primaryLoader.close();
				_primaryLoader = null;
			}
		}
		
		private function primaryLoaderCompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var xml:XML = new XML(loader.data);
			dispatchEvent(new PropertyCollectionEvent(PropertyCollectionEvent.LOAD_COMPLETE));
			deserialize(xml);
			dispatchEvent(new PropertyCollectionEvent(PropertyCollectionEvent.DESERIALIZE_COMPLETE));
			destroyPrimaryLoader();
		}
		
		public function deserialize(xml:XML):void
		{
			_map = new HashMap();
			
			for each( var prop:XML in xml.children() )
			{
				var propName:String = prop.localName();
				var type:String = prop.attribute("type");
				
				if(type.length == 0)
				{
					var item:* = prop.valueOf();
					put(prop.localName(), prop.valueOf());
				}
				else
				{
					switch(type.toLowerCase())
					{
						case "uint":
							var u:uint = prop.valueOf();
							put(propName, u);
						break;
						
						case "int":
							var i:int = prop.valueOf();
							put(propName, i);
						break;
						
						case "number":
							var n:Number = prop.valueOf();
							put(propName, n);
						break;
						
						case "boolean":
							put(propName, ((prop.valueOf()) == "true" || (prop.valueOf()) == "1") ? true : false);
						break;
						
						case "string":
						default:
							var s:String = prop.valueOf();
							put(propName,  s);
					}
				}
			}
		}
		
		public function contains(key:*):Boolean
		{
			return _map.containsKey(key);
		}
		
		public function get(key:*):*
		{
			return _map.containsKey(key) ? _map.get(key) : "@" + key + "@";
			//return _map.get(key);
		}
		
		public function put(key:*, value:*):void
		{
			_map.put(key, value);
		}
		
	}
}