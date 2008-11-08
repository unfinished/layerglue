package com.layerglue.flex3.base.preloader
{
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;
	import com.layerglue.lib.base.io.FlashVars;
	import com.layerglue.lib.base.io.LoadManager;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	import mx.preloaders.DownloadProgressBar;
	import flash.filters.BlurFilter;

	public class DownloadProgressBarExt extends DownloadProgressBar implements IPreloaderDisplayExt
	{
		private var _eventListenerCollection:EventListenerCollection;
		
		public function DownloadProgressBarExt()
		{
			super();
			
			filters = [new BlurFilter(0.00001, 0.00001, 1)];
		}
		
		override public function set preloader(value:Sprite):void
		{
			//value.addEventListener(FlexEvent.INIT_COMPLETE, initCompleteHandler);
			
			super.preloader = value;
		}
		
		protected function initCompleteHandler(event:FlexEvent):void
		{
			//event.stopImmediatePropagation();
			
			//dispatchEvent(new Event(Event.COMPLETE)); 
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			FlashVars.initialize(root);
			
			PreloadManager.initialize(this);
			
			_eventListenerCollection = new EventListenerCollection();
			
			_eventListenerCollection.createListener(PreloadManager.getInstance().initialLoadManager, MultiLoaderEvent.ITEM_PROGRESS, loaderChangeHandler);
			_eventListenerCollection.createListener(PreloadManager.getInstance().initialLoadManager, MultiLoaderEvent.ITEM_COMPLETE, loaderChangeHandler);
			
		}
		
		private function loaderChangeHandler(event:Event):void
		{
			var loadManager:LoadManager = PreloadManager.getInstance().initialLoadManager;
			
			if(loadManager is ProportionalLoadManager)
			{
				setProgress((loadManager as ProportionalLoadManager).currentValue, (loadManager as ProportionalLoadManager).totalValue);
			}
		}
		
		public function startTransitionOut():void
		{
			triggerComplete();
		}
		
		public function triggerComplete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}