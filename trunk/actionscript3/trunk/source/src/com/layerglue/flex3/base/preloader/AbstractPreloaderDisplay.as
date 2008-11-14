package com.layerglue.flex3.base.preloader
{
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;
	import com.layerglue.lib.base.io.FlashVars;
	import com.layerglue.lib.base.io.LoadManager;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	import com.layerglue.lib.base.loaders.RootLoaderProxy;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import mx.events.FlexEvent;
	import mx.events.RSLEvent;
	import mx.managers.SystemManager;
	import mx.preloaders.IPreloaderDisplay;
	import mx.preloaders.Preloader;
	
	/**
	 *  
	 */
	public class AbstractPreloaderDisplay extends Sprite implements IPreloaderDisplay
	{
		private var _creationTime:Number
		private var _eventListenerCollection:EventListenerCollection;
		
		public function AbstractPreloaderDisplay()
		{
			super();
			
			_eventListenerCollection = new EventListenerCollection();
			
			_backgroundAlpha = 1;
		}
		
		public function initialize():void
		{
			_creationTime = getTimer();
			
			_minimumDisplayTime = PreloadManager.getPreloaderMinDisplayTime(root as SystemManager);
			
			PreloadManager.initialize(this, createLoadManager());
			
			FlashVars.initialize(root);
			
			addListeners();
		}
		
		public function get systemManager():SystemManager
		{
			return root as SystemManager;
		}
		
		protected function createLoadManager():LoadManager
		{
			var loadManagerClassRef:Class = PreloadManager.getLoadManagerClassReference(root as SystemManager);
			var loadManagerTotalValue:Number = PreloadManager.getLoadManagerTotalValue(root as SystemManager);
			var loadManagerMainSWFValue:Number = PreloadManager.getLoadManagerMainSWFValue(root as SystemManager);
			
			var loadManager:LoadManager = new loadManagerClassRef();
			
			if(loadManager is ProportionalLoadManager)
			{
				(loadManager as ProportionalLoadManager).totalValue = loadManagerTotalValue;
			}
			
			var item:LoadManagerToken = new LoadManagerToken(
							new RootLoaderProxy(root.loaderInfo),
							null,
							null,
							loadManagerMainSWFValue);
			
			loadManager.addItem(item);
			
			return loadManager;
		}
		
		protected function addListeners():void
		{
			_eventListenerCollection = new EventListenerCollection();
			
			_eventListenerCollection.createListener(PreloadManager.getInstance().loadManager, MultiLoaderEvent.ITEM_PROGRESS, loaderChangeHandler);
			_eventListenerCollection.createListener(PreloadManager.getInstance().loadManager, MultiLoaderEvent.ITEM_COMPLETE, loaderChangeHandler);
			_eventListenerCollection.createListener(PreloadManager.getInstance().loadManager, Event.COMPLETE, loaderCompleteHandler);
			_eventListenerCollection.createListener(this, Event.COMPLETE, preloaderPhaseCompleteHandler);
		}
		
		protected function removeListeners():void
		{
			if(_eventListenerCollection)
			{
				_eventListenerCollection.destroy();
				_eventListenerCollection = null;
			}
		}
		
		protected function loaderChangeHandler(event:Event):void
		{
		}
		
		protected function loaderCompleteHandler(event:Event):void
		{
		}
		
		protected function preloaderPhaseCompleteHandler(event:Event):void
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
		
		public function set preloader(value:Sprite):void
		{
			PreloadManager.getInstance().flexPreloader = value as Preloader;
			
			_eventListenerCollection.createListener(value, ProgressEvent.PROGRESS, progressHandler);	
			_eventListenerCollection.createListener(value, Event.COMPLETE, completeHandler);
			
			_eventListenerCollection.createListener(value, RSLEvent.RSL_PROGRESS, rslProgressHandler);
			_eventListenerCollection.createListener(value, RSLEvent.RSL_COMPLETE, rslCompleteHandler);
			_eventListenerCollection.createListener(value, RSLEvent.RSL_ERROR, rslErrorHandler);
			
			_eventListenerCollection.createListener(value, FlexEvent.INIT_PROGRESS, initProgressHandler);
			_eventListenerCollection.createListener(value, FlexEvent.INIT_COMPLETE, initCompleteHandler);
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
			complete();
		}
		
		private function complete():void
		{
			removeListeners();
			
			dispatchCompleteEvent();
		}
		
		private function dispatchCompleteEvent():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function destroy():void
		{
			removeListeners();
			
			if(parent)
			{
				parent.removeChild(this);
			}
		}
		
	}
}