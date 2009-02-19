package com.layerglue.font
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.text.Font;
	
	public class FontManager extends EventDispatcher
	{
		public function FontManager(enforcer:SingletonEnforcer)
		{
			super();
		}
		
		private static var _instance:FontManager;
		
		public static function getInstance():FontManager
		{
			if (!_instance)
			{
				_instance = new FontManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function loadCompiledFont(url:String):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, compiledFontLoaded, false, 0, true);
			loader.load(new URLRequest(url));
		}
		
		private function compiledFontLoaded(event:Event):void
		{
			dispatchEvent(event);
		}
	}
}

class SingletonEnforcer {};