package com.layerglue.flash.preloader
{
	
	import com.layerglue.flex3.base.events.PreloadManagerEvent;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class FlashPreloadManager extends EventDispatcher
	{
		private var _preloaderDisplay:IFlashPreloaderDisplay
		
		public function get preloaderDisplay():IFlashPreloaderDisplay
		{
			return _preloaderDisplay
		}
		
		public function FlashPreloadManager(preloaderDisplay:IFlashPreloaderDisplay)
		{
			super();
			
			_preloaderDisplay = preloaderDisplay;
			_preloaderDisplay.rootLoaderProxy.addEventListener(Event.COMPLETE, rootLoadCompleteHandler);
			
			_loadManager = new ProportionalLoadManager();
			_loadManager.addEventListener(Event.COMPLETE, initialAssetsLoadCompleteHandler);
		}
		
		private static var _instance:FlashPreloadManager;
		
		public static function initialize(preloaderDisplay:IFlashPreloaderDisplay):FlashPreloadManager
		{
			if(!_instance)
			{
				_instance = new FlashPreloadManager(preloaderDisplay);
			}
			
			return _instance;
		}
		
		public static function getInstance():FlashPreloadManager
		{
			return _instance;
		}
		
		private var _loadManager:ProportionalLoadManager;
		
		/**
		 * The ProportionalLoadManager responsible for the managing and measuring the initial assets
		 * to be loaded in to the site.
		 * 
		 * <p></p>
		 */
		public function get loadManager():ProportionalLoadManager
		{
			return _loadManager;
		}
		
		private function initialAssetsLoadCompleteHandler(event:Event):void
		{
			dispatchEvent(new PreloadManagerEvent(PreloadManagerEvent.INITIAL_ASSETS_LOAD_COMPLETE));
			
			//preloaderDisplay.showMainApp();
			trace("PreloaderManager - intialAssetsLoadCompleteHandler");
		}
		
		private function rootLoadCompleteHandler(event:Event):void
		{
			dispatchEvent(new PreloadManagerEvent(PreloadManagerEvent.ROOT_LOAD_COMPLETE));
			
			trace("PreloaderManager - rootLoadCompleteHandler");
		}
		
	}
}