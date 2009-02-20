package com.client.project.preloader
{
	import com.layerglue.flash.preloader.AbstractFlashPreloaderDisplay;
	import com.layerglue.flash.preloader.FlashPreloadManager;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	public class CustomPreloaderDisplay extends AbstractFlashPreloaderDisplay
	{
		public function CustomPreloaderDisplay()
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		override protected function createChildren():void
		{
			super.createChildren()
			
			FlashPreloadManager.getInstance().loadManager.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
			FlashPreloadManager.getInstance().loadManager.addEventListener(Event.COMPLETE, loadCompleteHandler);
		}
		
		private function loadProgressHandler(event:Event):void
		{
			trace(">>>>>>>>>>>>>> loadProgressHandler");
		}
		
		private function loadCompleteHandler(event:Event):void
		{
			trace(">>>>>>>>>>>>>> loadCompleteHandler");
		}
	}
}