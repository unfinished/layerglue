package com.layerglue.flex3.base.preloader
{
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;
	import com.layerglue.lib.base.io.FlashVars;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import mx.events.FlexEvent;
	import mx.events.RSLEvent;
	import mx.preloaders.Preloader;
	
	/**
	 *  
	 */
	public class AbstractPreloaderDisplay extends Sprite implements IPreloaderDisplayExt
	{
		private var _creationTime:Number
		private var _eventListenerCollection:EventListenerCollection;
		
		public function AbstractPreloaderDisplay()
		{
			super();
			
			_eventListenerCollection = new EventListenerCollection();
			
			_backgroundAlpha = 1;
			
			minDisplayTime = 0;
		}
		
		public function initialize():void
		{
			_creationTime = getTimer();
			
			PreloadManager.initialize(this);
			
			FlashVars.initialize(root);
			
			_eventListenerCollection.createListener(PreloadManager.getInstance().initialLoadManager, MultiLoaderEvent.ITEM_PROGRESS, loaderChangeHandler);
			_eventListenerCollection.createListener(PreloadManager.getInstance().initialLoadManager, MultiLoaderEvent.ITEM_COMPLETE, loaderChangeHandler);
			_eventListenerCollection.createListener(stage, Event.RESIZE, stageSizeChangeHandler);
		}
		
		protected function loaderChangeHandler(event:Event):void
		{
		}
		
		protected function stageSizeChangeHandler(event:Event):void
		{
		}
		
		private var _minimumDisplayTime:Number 
		
		public function get minDisplayTime():Number
		{
			return _minimumDisplayTime;
		}
		
		public function set minDisplayTime(value:Number):void
		{
			_minimumDisplayTime = value;
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
		
		private var _flexPreloader:Preloader;
		
		public function get flexPreloader():Preloader
		{
			return _flexPreloader;
		}
		
		public function set flexPreloader(obj:Preloader):void
		{
			_flexPreloader = obj;
			
			_eventListenerCollection.createListener(_flexPreloader, ProgressEvent.PROGRESS, progressHandler);	
			_eventListenerCollection.createListener(_flexPreloader, Event.COMPLETE, completeHandler);
			
			_eventListenerCollection.createListener(_flexPreloader, RSLEvent.RSL_PROGRESS, rslProgressHandler);
			_eventListenerCollection.createListener(_flexPreloader, RSLEvent.RSL_COMPLETE, rslCompleteHandler);
			_eventListenerCollection.createListener(_flexPreloader, RSLEvent.RSL_ERROR, rslErrorHandler);
			
			_eventListenerCollection.createListener(_flexPreloader, FlexEvent.INIT_PROGRESS, initProgressHandler);
			_eventListenerCollection.createListener(_flexPreloader, FlexEvent.INIT_COMPLETE, initCompleteHandler);
		}
		
		//This getter setter is defined by the IPreloaderDisplay interface
		public function get preloader():Sprite
		{
			return flexPreloader;
		}
		
		public function set preloader(value:Sprite):void
		{
			flexPreloader = value as Preloader;
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
		
		protected function get elapsedDisplayTime():Number
		{
			return getTimer() - _creationTime;
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
			if(elapsedDisplayTime >= minDisplayTime)
			{
				dispatchCompleteEvent();
			}
			else
			{
				var t:Timer = new Timer(minDisplayTime - elapsedDisplayTime, 1);
				_eventListenerCollection.createListener(t, TimerEvent.TIMER_COMPLETE, minDisplayTimeTimerComplete);
				t.start();
			}
		}
		
		private function minDisplayTimeTimerComplete(event:TimerEvent):void
		{
			dispatchCompleteEvent();
		}
		
		private function dispatchCompleteEvent():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function destroy():void
		{
			_eventListenerCollection.destroy();
			_eventListenerCollection = null;
			
			if(parent)
			{
				parent.removeChild(this);
			}
		}
		
	}
}