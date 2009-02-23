package com.layerglue.flash.preloader
{
	
	import com.layerglue.flex3.base.events.PreloadManagerEvent;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	import com.layerglue.lib.base.loaders.RootLoaderProxy;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;

	public class FlashPreloadManager extends EventDispatcher
	{
		private var _preloaderDisplay:IRootPreloader
		
		public function get preloaderDisplay():IRootPreloader
		{
			return _preloaderDisplay
		}
		
		public function FlashPreloadManager(preloaderDisplay:IRootPreloader)
		{
			super();
			
			_preloaderDisplay = preloaderDisplay;
			_preloaderDisplay.rootLoaderProxy.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
			_preloaderDisplay.rootLoaderProxy.addEventListener(Event.COMPLETE, rootLoadCompleteHandler);
			
			_loadManager = new ProportionalLoadManager();
			
			_loadManager.addItem(
					new LoadManagerToken(
					new RootLoaderProxy((preloaderDisplay as DisplayObject).stage.loaderInfo),
					null,
					null,
					preloaderDisplay.rootLoadProportion)
				);
			
			
			_loadManager.addEventListener(Event.COMPLETE, initialAssetsLoadCompleteHandler);
		}
		
		
		
		private static var _instance:FlashPreloadManager;
		
		public static function initialize(preloaderDisplay:IRootPreloader):FlashPreloadManager
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
		}
		
		private function loadProgressHandler(event:Event):void
		{
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}
		
		private function rootLoadCompleteHandler(event:Event):void
		{
			dispatchEvent(new PreloadManagerEvent(PreloadManagerEvent.ROOT_LOAD_COMPLETE));
		}
		
	}
}