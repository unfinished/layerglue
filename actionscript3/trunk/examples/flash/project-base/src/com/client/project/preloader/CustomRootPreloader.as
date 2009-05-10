package com.client.project.preloader
{
	import com.layerglue.flash.preloader.AbstractRootPreloader;
	import com.layerglue.flash.preloader.FlashPreloadManager;

	import flash.display.DisplayObject;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class CustomRootPreloader extends AbstractRootPreloader
	{
		public function CustomRootPreloader()
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_preloaderDisplay = new PreloaderProgressBar(FlashPreloadManager.getInstance());
			addChild(_preloaderDisplay as DisplayObject);
		}
		
	}
}