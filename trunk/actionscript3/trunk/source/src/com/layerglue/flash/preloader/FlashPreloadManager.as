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
	import com.layerglue.lib.base.events.PreloaderViewEvent;

	[Event(name="rootLoadComplete", type="com.layerglue.lib.base.events.PreloadManagerEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	
	public class FlashPreloadManager extends EventDispatcher
	{
		private var _swfRoot:ISWFRoot;
		private var _mainInstance:IPreloadableFlashApplication;
		
		public function get swfRoot():ISWFRoot
		{
			return _swfRoot;
		}
		
		public function FlashPreloadManager(swfRoot:ISWFRoot)
		{
			super();
			
			_swfRoot = swfRoot;
			_loadManager = new ProportionalLoadManager();
			_loadManager.totalValue = swfRoot.totalLoadValue;
			
			_loadManager.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
			_swfRoot.rootLoaderProxy.addEventListener(Event.COMPLETE, rootLoadCompleteHandler);
			_swfRoot.addEventListener(PreloaderViewEvent.ANIMATION_COMPLETE, preloaderViewCompleteHandler, false, 0, true);
			
			_loadManager.addItem(
					new LoadManagerToken(
					_swfRoot.rootLoaderProxy,
					null,
					null,
					_swfRoot.rootLoadProportion)
				);
			
			_loadManager.addEventListener(Event.COMPLETE, initialAssetsLoadCompleteHandler);
		}
		
		private static var _instance:FlashPreloadManager;
		
		public static function initialize(swfRoot:ISWFRoot):FlashPreloadManager
		{
			if(!_instance)
			{
				_instance = new FlashPreloadManager(swfRoot);
				
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
			//_rootPreloader.showMainInstance(_mainInstance);
		}
		
		private function preloaderViewCompleteHandler(event:Event):void
		{
			_swfRoot.addMainInstanceToDisplayList(_mainInstance);
			_mainInstance.show(swfRoot.preloaderView);
		}
	}
}