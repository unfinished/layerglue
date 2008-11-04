package com.layerglue.flex3.base.preloader
{
	import com.layerglue.flex3.base.events.PreloaderManagerEvent;
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.io.FlashVars;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import mx.events.FlexEvent;
	import mx.events.RSLEvent;
	import mx.preloaders.IPreloaderDisplay;
	
	/**
	 *  
	 */
	public class AbstractPreloaderView extends Sprite implements IPreloaderDisplayExt
	{
		private var _eventListenerCollection:EventListenerCollection;
		
		public function AbstractPreloaderView()
		{
			super();
			
			
			
			_eventListenerCollection = new EventListenerCollection();
			
			_backgroundAlpha = 1;
		}
		
		public function initialize():void
		{
			PreloaderManager.initialize(this);
			
			FlashVars.initialize(root);
			
			_eventListenerCollection.createListener(PreloaderManager.getInstance(), PreloaderManagerEvent.INITIAL_ASSETS_LOAD_COMPLETE, initialAssetsLoadCompleteHandler);
		}
		
		public function startTransitionOut():void
		{
			triggerComplete();
		}
		
		public function triggerComplete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private var _backgroundAlpha:Number;

		public function get backgroundAlpha():Number
		{
			return _backgroundAlpha;
		}
		
		public function set backgroundAlpha(value:Number):void
		{
			_backgroundAlpha = value;
		}

		private var _backgroundColor:uint;
		
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}
		
		public function set backgroundColor(value:uint):void
		{
			_backgroundColor = value;
		}
		
		private var _backgroundImage:Object;

		
		public function get backgroundImage():Object
		{
			return _backgroundImage;
		}
		
		public function set backgroundImage(value:Object):void
		{
			_backgroundImage = value;
		}
		
		private var _backgroundSize:String;
		
		public function get backgroundSize():String
		{
			return _backgroundSize
		}
		
		public function set backgroundSize(value:String):void
		{
			_backgroundSize = value;
		}
		
		private var _preloader:Sprite;
		
		public function set preloader(obj:Sprite):void
		{
			_preloader = obj;
			
			_eventListenerCollection.createListener(_preloader, ProgressEvent.PROGRESS, progressHandler);	
			_eventListenerCollection.createListener(_preloader, Event.COMPLETE, completeHandler);
			
			_eventListenerCollection.createListener(_preloader, RSLEvent.RSL_PROGRESS, rslProgressHandler);
			_eventListenerCollection.createListener(_preloader, RSLEvent.RSL_COMPLETE, rslCompleteHandler);
			_eventListenerCollection.createListener(_preloader, RSLEvent.RSL_ERROR, rslErrorHandler);
			
			_eventListenerCollection.createListener(_preloader, FlexEvent.INIT_PROGRESS, initProgressHandler);
			_eventListenerCollection.createListener(_preloader, FlexEvent.INIT_COMPLETE, initCompleteHandler);
		}
		
		private var _stageHeight:Number;
		
		public function get stageHeight():Number
		{
			return _stageHeight;
		}
		
		public function set stageHeight(value:Number):void
		{
			_stageHeight = value;
		}
		
		private var _stageWidth:Number;
		
		public function get stageWidth():Number
		{
			return _stageWidth
		}
		
		public function set stageWidth(value:Number):void
		{
			_stageWidth = value;
		}
		
		protected function progressHandler(event:ProgressEvent):void
		{
			
		}
		
		protected function completeHandler(event:Event):void
		{
			
		}
			
		protected function rslProgressHandler(event:RSLEvent):void
		{
			
		}
		
		protected function rslCompleteHandler(event:RSLEvent):void
		{
			
		}
		
		protected function rslErrorHandler(event:RSLEvent):void
		{
			
		}
		
		protected function initProgressHandler(event:FlexEvent):void
		{
			
		}
		
		protected function initCompleteHandler(event:FlexEvent):void
		{
			//The standard Flex preloader view dispatches a complete event at this point which
			//triggers the SystemManager to remove the preloder from the stage, add the application
			//instance to the stage and make it fire FlexEvent.APPLICATION_COMPLETE.
			
			//dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function initialAssetsLoadCompleteHandler(event:PreloaderManagerEvent):void
		{
			trace("preloader heard assets load complete");
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}