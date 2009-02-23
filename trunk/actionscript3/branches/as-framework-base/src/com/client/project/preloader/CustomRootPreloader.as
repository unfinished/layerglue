package com.client.project.preloader
{
	import com.layerglue.flash.preloader.AbstractRootPreloader;
	import com.layerglue.flex3.base.events.PreloadManagerEvent;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ProgressEvent;

	public class CustomRootPreloader extends AbstractRootPreloader
	{
		public function CustomRootPreloader()
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		private var _progressBar:PreloaderProgressBar;
		
		override protected function createChildren():void
		{
			super.createChildren()
			
			_progressBar = new PreloaderProgressBar()
			addChild(_progressBar);
		}
		
		override protected function loadProgressHandler(event:ProgressEvent):void
		{
			trace(">>>>>>>>>>>>>> CustomPreloaderDisplay.loadProgressHandler");
		}
		
		override protected function rootLoadCompleteHandler(event:PreloadManagerEvent):void
		{
			super.rootLoadCompleteHandler(event);
			
			trace(">>>>>>>>>>>>>> CustomPreloaderDisplay.rootLoadCompleteHandler");
		}
		
		override protected function initialAssetLoadCompleteHandler(event:PreloadManagerEvent):void
		{
			super.initialAssetLoadCompleteHandler(event);
			
			trace(">>>>>>>>>>>>>> CustomPreloaderDisplay.initialAssetLoadCompleteHandler");
		}
		
		
	}
}