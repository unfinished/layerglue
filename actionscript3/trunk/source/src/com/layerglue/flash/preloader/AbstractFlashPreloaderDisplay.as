package com.layerglue.flash.preloader
{
	import com.layerglue.flash.applications.IPreloadableFlashApplication;
	import com.layerglue.flex3.base.events.PreloadManagerEvent;
	import com.layerglue.lib.base.io.FlashVars;
	import com.layerglue.lib.base.loaders.RootLoaderProxy;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;

	public class AbstractFlashPreloaderDisplay extends MovieClip implements IFlashPreloaderDisplay
	{
		public function AbstractFlashPreloaderDisplay()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			_rootLoaderProxy = new RootLoaderProxy(loaderInfo);
			
			FlashPreloadManager.initialize(this);
			
			stop();
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
			FlashPreloadManager.getInstance().addEventListener(PreloadManagerEvent.ROOT_LOAD_COMPLETE, rootLoadCompleteHandler, false, 0, true);
			FlashPreloadManager.getInstance().addEventListener(PreloadManagerEvent.INITIAL_ASSETS_LOAD_COMPLETE, initialAssetLoadCompleteHandler, false, 0, true);
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
		
		protected function rootLoadCompleteHandler(event:Event):void
		{
			startInitialAssetLoad();
		}
		
		protected function initialAssetLoadCompleteHandler(event:PreloadManagerEvent):void
		{
			showMainApp();
		}
		
		private var _rootLoaderProxy:RootLoaderProxy;
		
		public function get rootLoaderProxy():RootLoaderProxy
		{
			return _rootLoaderProxy;
		}
		
		public function get rootLoadProportion():Number
		{
			return 0.6;
		}
		
		public function get mainClassName():String
		{
			return "Main";
		}
		
		public function showMainApp():void
		{
			destroy();
			
			addChild(_mainMovie as DisplayObject);
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
		
		protected function destroy():void
		{
			//Destroy preloader view stuff here. DO NOT do a parent.removeChild(this) as this is the root MovieClip
		}
		
		protected function createChildren():void
		{
			
		}
		
		
	}
}