package com.layerglue.flex3.base.preloader
{
	import com.layerglue.lib.base.io.LoadManager;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	import com.layerglue.lib.base.loaders.RootLoaderProxy;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.layerglue.lib.base.io.ProportionalLoadManagerToken;
	
	/**
	 * A proxy to sit between the preloader and the main application
	 */
	public class PreloadManager extends EventDispatcher
	{
		private var _loadManager:LoadManager;
		
		public function PreloadManager(preloader:IPreloaderDisplayExt)
		{
			super();
			
			_preloaderView = preloader;
			
			_loadManager = new ProportionalLoadManager();
			//_loadManager = new LoadManager();
			
			var item:ProportionalLoadManagerToken = new ProportionalLoadManagerToken(
							new RootLoaderProxy((preloaderView as DisplayObject).root.loaderInfo),
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
		
		public static function initialize(preloader:IPreloaderDisplayExt):PreloadManager
		{
			if(!_instance)
			{
				_instance = new PreloadManager(preloader);
			}
			
			return _instance;
		}
		
		public static function getInstance():PreloadManager
		{
			return _instance;
		}
		
		private var _preloaderView:IPreloaderDisplayExt;
		
		public function get preloaderView():IPreloaderDisplayExt
		{
			return _preloaderView;
		}
		
		public function get initialLoadManager():LoadManager
		{
			return _loadManager;
		}
		
		private function rootLoadCompleteHandler(event:Event):void
		{
		}
	}
}