package com.layerglue.flash.preloader
{
	import com.layerglue.flash.applications.IPreloadableFlashApplication;
	import com.layerglue.lib.base.events.PreloadManagerEvent;
	import com.layerglue.lib.base.io.FlashVars;
	import com.layerglue.lib.base.loaders.RootLoaderProxy;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	public class AbstractRootPreloader extends MovieClip implements IRootPreloader
	{
		
		public function AbstractRootPreloader()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			_rootLoaderProxy = new RootLoaderProxy(loaderInfo);
			
			FlashPreloadManager.initialize(this);
			
			stop();
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
			FlashPreloadManager.getInstance().addEventListener(PreloadManagerEvent.ROOT_LOAD_COMPLETE, rootLoadCompleteHandler, false, 0, true);
			FlashPreloadManager.getInstance().addEventListener(Event.COMPLETE, totalLoadCompleteHandler, false, 0, true);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			FlashVars.initialize(stage);
			createChildren();
		}
		
		protected function enterFrameHandler(event:Event):void
		{
			if(framesLoaded == totalFrames)
			{
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler, false);
			}
		}
		
		protected function rootLoadCompleteHandler(event:PreloadManagerEvent):void
		{
			startInitialAssetLoad();
		}
		
		protected function totalLoadCompleteHandler(event:Event):void
		{
			showMainApp();
		}
		
		protected var _mainMovie:IPreloadableFlashApplication;
		
		protected function startInitialAssetLoad():void
		{
			nextFrame();
			
			var mainClassReference:Class = Class(getDefinitionByName("Main"));
			
			if(mainClassReference)
			{
				_mainMovie = new mainClassReference();
				
				_mainMovie.startInitialLoad();
			}
		}
		
		protected function createChildren():void
		{
			//Must be overriden in subclasses to create the visual loader
		}
		
		// IRootPreloaderImplementation -----------------------------------------------------------\
		
		private var _rootLoaderProxy:RootLoaderProxy;
		
		public function get rootLoaderProxy():RootLoaderProxy
		{
			return _rootLoaderProxy;
		}
		
		protected var _preloaderDisplay:DisplayObject;
		
		public function get preloaderDisplay():DisplayObject
		{
			return _preloaderDisplay;
		}
		
		public function get rootLoadProportion():Number
		{
			return 0.6;
		}
		
		public function get minDisplayTime():Number
		{
			return 1000;
		}
		
		public function get mainClassName():String
		{
			return "Main";
		}
		
		public function showMainApp():void
		{
			addChildAt(_mainMovie as DisplayObject, 0);
			_mainMovie.show(_preloaderDisplay);
		}
		
		// IRootPreloaderImplementation -----------------------------------------------------------/
	}
}