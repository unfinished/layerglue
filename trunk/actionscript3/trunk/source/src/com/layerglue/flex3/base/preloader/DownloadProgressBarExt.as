package com.layerglue.flex3.base.preloader
{
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.io.FlashVars;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	import mx.preloaders.DownloadProgressBar;

	public class DownloadProgressBarExt extends DownloadProgressBar implements IPreloaderDisplayExt
	{
		private var _eventListenerCollection:EventListenerCollection;
		
		public function DownloadProgressBarExt()
		{
			super();
			
			PreloaderManager.initialize(this);
		}
		
		override public function set preloader(value:Sprite):void
		{
			value.addEventListener(FlexEvent.INIT_COMPLETE, initCompleteHandler);
			
			super.preloader = value;
		}
		
		protected function initCompleteHandler(event:FlexEvent):void
		{
			event.stopImmediatePropagation();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			FlashVars.initialize(root);
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