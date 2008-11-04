package com.layerglue.flex3.base.preloader
{
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	import com.layerglue.lib.base.loaders.RootLoaderProxy;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * A proxy to sit between the preloader and the main application
	 */
	public class PreloaderManager extends EventDispatcher
	{
		private var _initialLoadManager:ProportionalLoadManager
		
		public function PreloaderManager(preloader:IPreloaderDisplayExt)
		{
			super();
			
			_preloaderView = preloader;
			
			_initialLoadManager = new ProportionalLoadManager();
			_initialLoadManager.addItem(
										new RootLoaderProxy((preloaderView as DisplayObject).root.loaderInfo),
										rootLoadCompleteHandler,
										null);
			_initialLoadManager.start();
		}
		
		private static var _instance:PreloaderManager;
		
		public static function initialize(preloader:IPreloaderDisplayExt):PreloaderManager
		{
			if(!_instance)
			{
				_instance = new PreloaderManager(preloader);
			}
			
			return _instance;
		}
		
		public static function getInstance():PreloaderManager
		{
			return _instance;
		}
		
		private var _preloaderView:IPreloaderDisplayExt;
		
		public function get preloaderView():IPreloaderDisplayExt
		{
			return _preloaderView;
		}
		
		public function get initialLoadManager():ProportionalLoadManager
		{
			return _initialLoadManager;
		}
		
		private function rootLoadCompleteHandler(event:Event):void
		{
			trace("root load complete")	
		}
	}
}