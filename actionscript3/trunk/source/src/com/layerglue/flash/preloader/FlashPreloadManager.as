package com.layerglue.flash.preloader
{
	import com.layerglue.lib.base.events.PreloadManagerEvent;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	[Event(name="initialAssetsLoadComplete", type="com.layerglue.lib.base.events.PreloadManagerEvent")]
	[Event(name="rootLoadComplete", type="com.layerglue.lib.base.events.PreloadManagerEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="complete", type="flash.events.Event")]
	
	public class FlashPreloadManager extends EventDispatcher
	{
		private var _rootPreloader:IRootPreloader
		private var _startTime:int;
		
		public function get preloaderDisplay():IRootPreloader
		{
			return _rootPreloader
		}
		
		public function FlashPreloadManager(preloaderDisplay:IRootPreloader)
		{
			super();
			
			_startTime = getTimer();
			
			_rootPreloader = preloaderDisplay;
			_rootPreloader.rootLoaderProxy.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
			_rootPreloader.rootLoaderProxy.addEventListener(Event.COMPLETE, rootLoadCompleteHandler);
			
			_loadManager = new ProportionalLoadManager();
			
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
			dispatchEvent(new PreloadManagerEvent(PreloadManagerEvent.INITIAL_ASSETS_LOAD_COMPLETE));
			
			var currentTime:int = getTimer();
			
			if(currentTime >= _startTime + preloaderDisplay.minDisplayTime)
			{
				triggerComplete();
			}
			else
			{
				setTimeout(triggerComplete, preloaderDisplay.minDisplayTime - currentTime);
			}
		}
		
		protected function triggerComplete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}