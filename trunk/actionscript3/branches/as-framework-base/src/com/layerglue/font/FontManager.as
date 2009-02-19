package com.layerglue.font
{
	import com.layerglue.flash.loaders.DisplayLoader;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	public class FontManager extends EventDispatcher
	{
		private static var _instance:FontManager;
		
		private var _loader:DisplayLoader;
		
		public function get loader():Loader
		{
			return _loader;
		}
		
		public function FontManager(enforcer:SingletonEnforcer)
		{
			super();
			
			_loader = new DisplayLoader();
			_loader.addEventListener(Event.COMPLETE, loadCompleteHandler, false, 0, true);
		}
		
		public static function getInstance():FontManager
		{
			if (!_instance)
			{
				_instance = new FontManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		private function loadCompleteHandler(event:Event):void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}

class SingletonEnforcer {};