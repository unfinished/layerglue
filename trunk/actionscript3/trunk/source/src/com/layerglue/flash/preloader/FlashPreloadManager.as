package com.layerglue.flash.preloader
{
	import com.layerglue.flash.applications.IPreloadableFlashApplication;
	import com.layerglue.lib.base.events.PreloadManagerEvent;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import com.layerglue.lib.base.loaders.RootLoaderProxy;

	[Event(name="rootLoadComplete", type="com.layerglue.lib.base.events.PreloadManagerEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	
	public class FlashPreloadManager extends EventDispatcher
	{
		private var _rootPreloader:IRootPreloader;
		private var _mainInstance:IPreloadableFlashApplication;
		
		public function get preloaderDisplay():IRootPreloader
		{
			return _rootPreloader;
		}
		
		public function FlashPreloadManager(preloaderDisplay:IRootPreloader)
		{
			super();
			
			_rootPreloader = preloaderDisplay;
			_loadManager = new ProportionalLoadManager();
			
			_loadManager.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
			_rootPreloader.rootLoaderProxy.addEventListener(Event.COMPLETE, rootLoadCompleteHandler);
			_rootPreloader.addEventListener(Event.COMPLETE, preloaderDisplayCompleteHandler, false, 0, true);
			
			_loadManager.addItem(
					new LoadManagerToken(
					preloaderDisplay.rootLoaderProxy,
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
		
		public function registerMainInstance(mainInstance:IPreloadableFlashApplication):void
		{
			_mainInstance = mainInstance;
		}
		
		private function loadProgressHandler(event:Event):void
		{
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}
		
		private function rootLoadCompleteHandler(event:Event):void
		{
			dispatchEvent(new PreloadManagerEvent(PreloadManagerEvent.ROOT_LOAD_COMPLETE));
		}
		
		private function initialAssetsLoadCompleteHandler(event:Event):void
		{
			_rootPreloader.showMainInstance(_mainInstance);
		}
		
		private function preloaderDisplayCompleteHandler(event:Event):void
		{
			_mainInstance.show(preloaderDisplay as DisplayObject);
		}
	}
}