package com.layerglue.flex3.base.preloader
{
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filters.BlurFilter;
	
	import mx.managers.SystemManager;
	import mx.preloaders.DownloadProgressBar;
	import mx.preloaders.IPreloaderDisplay;
	import mx.preloaders.Preloader;

	public class DownloadProgressBarExt extends DownloadProgressBar implements IPreloaderDisplay
	{
		
		private var _eventListenerCollection:EventListenerCollection;
		
		public function DownloadProgressBarExt()
		{
			super();
			
			filters = [new BlurFilter(0.00001, 0.00001, 1)];
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			minDisplayTime = PreloadManager.getPreloaderMinDisplayTime(root as SystemManager);
			
			PreloadManager.initialize(this);
			
			addListeners();
			
			setProgress(0, 0);
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
		
		override protected function createChildren():void
		{
			super.createChildren();
		}
		
		override protected function showDisplayForDownloading(elapsedTime:int, event:ProgressEvent):Boolean
		{
			return true;
		}
		
		override protected function showDisplayForInit(elapsedTime:int, count:int):Boolean
		{
			return true;
		}
		
		public function get minDisplayTime():Number
		{
			return MINIMUM_DISPLAY_TIME;
		}
		
		public function set minDisplayTime(value:Number):void
		{
			MINIMUM_DISPLAY_TIME = value;
		}
		
		override public function set preloader(obj:Sprite):void
		{
			super.preloader = obj;
			
			PreloadManager.getInstance().flexPreloader = obj as Preloader;
		}
		
		private function loaderChangeHandler(event:Event):void
		{
			var loadManager:ProportionalLoadManager = PreloadManager.getInstance().loadManager;
			
			setProgress(loadManager.currentValue, loadManager.totalValue);
		}
		
		protected function loaderCompleteHandler(event:Event):void
		{
		}
		
		protected function preloaderPhaseCompleteHandler(event:Event):void
		{
			removeListeners();
		}
		
		override protected function setProgress(completed:Number, total:Number):void
		{
			var loadManager:ProportionalLoadManager = PreloadManager.getInstance().loadManager;
			
			if( loadManager is ProportionalLoadManager)
			{
				if( completed == loadManager.currentValue && total == loadManager.totalValue )
				{
					super.setProgress(completed, total);
				}
			}
			
			super.setProgress(completed, total);
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