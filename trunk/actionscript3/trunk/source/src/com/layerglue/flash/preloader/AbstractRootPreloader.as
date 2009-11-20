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
	import flash.utils.getTimer;

	public class AbstractRootPreloader extends MovieClip implements IRootPreloader
	{
		protected var _mainInstance:IPreloadableFlashApplication;
		
		public function AbstractRootPreloader()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			_rootLoaderProxy = new RootLoaderProxy(loaderInfo);
			
			FlashPreloadManager.initialize(this);
			
			stop();
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
			FlashPreloadManager.getInstance().addEventListener(PreloadManagerEvent.ROOT_LOAD_COMPLETE, rootLoadCompleteHandler, false, 0, true);
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
			nextFrame();
			createMainInstance();
			startInitialAssetLoad();
		}
		
		protected function createMainInstance():void
		{
			var mainClassReference:Class = Class(getDefinitionByName(mainClassName));
			
			if(mainClassReference)
			{
				_mainInstance = new mainClassReference();
			}
		}
		
		public function showMainInstance(mainInstance:IPreloadableFlashApplication):void
		{
			addChildAt(mainInstance as DisplayObject, 0);
			mainInstance.show(_preloaderDisplay);
		}
		
		protected function startInitialAssetLoad():void
		{
			_mainInstance.startInitialLoad();
		}
		
		protected function createChildren():void
		{
			//Must be overriden in subclasses to create the visual loader
		}
		
		private var _isComplete:Boolean;
		
		protected function get isComplete():Boolean
		{
			return _isComplete;
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
			return NaN;
		}
		
		public function get mainClassName():String
		{
			return "Main";
		}
		
		// IRootPreloaderImplementation -----------------------------------------------------------/
		
	}
}