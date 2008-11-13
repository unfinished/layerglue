package com.layerglue.flex3.base.preloader
{
	import com.layerglue.lib.base.io.LoadManager;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	import com.layerglue.lib.base.io.ProportionalLoadManagerToken;
	import com.layerglue.lib.base.loaders.RootLoaderProxy;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.preloaders.IPreloaderDisplay;
	import mx.preloaders.Preloader;
	
	/**
	 * A proxy to sit between the preloader and the main application
	 */
	public class PreloadManager extends EventDispatcher
	{
		private var _loadManager:LoadManager;
		
		public function PreloadManager(preloaderDisplay:IPreloaderDisplay)
		{
			super();
			
			_preloaderDisplay = preloaderDisplay;
			
			_loadManager = new ProportionalLoadManager();
			//_loadManager = new LoadManager();
			
			var item:ProportionalLoadManagerToken = new ProportionalLoadManagerToken(
							new RootLoaderProxy((preloaderDisplay as DisplayObject).root.loaderInfo),
							rootLoadCompleteHandler,
							null,
							0.6);
			
			
			_loadManager.addItem(item);
			_loadManager.start();
		}
		
		/*
		private function createLoadManager():LoadManager
		{
			return new ProportionalLoadManager();
		}
		
		private function createRootLoaderToken():LoadManagerToken
		{
			return new ProportionalLoadManagerToken(
							new RootLoaderProxy((preloaderView as DisplayObject).root.loaderInfo),
							rootLoadCompleteHandler,
							null,
							0.6);
		}
		*/
		 
		private static var _instance:PreloadManager;
		
		public static function initialize(preloaderDisplay:IPreloaderDisplay):PreloadManager
		{
			if(!_instance)
			{
				_instance = new PreloadManager(preloaderDisplay);
			}
			
			return _instance;
		}
		
		public static function getInstance():PreloadManager
		{
			return _instance;
		}
		
		private var _preloaderDisplay:IPreloaderDisplay;
		
		public function get preloaderDisplay():IPreloaderDisplay
		{
			return _preloaderDisplay;
		}
		
		private var _flexPreloader:Preloader;
		
		public function get flexPreloader():Preloader
		{
			return _flexPreloader;
		}
		
		public function set flexPreloader(value:Preloader):void
		{
			_flexPreloader = value;
		}
		
		public function get initialLoadManager():LoadManager
		{
			return _loadManager;
		}
		
		private function rootLoadCompleteHandler(event:Event):void
		{
			//trace("rootLoadCompleteHandler");
		}
	}
}