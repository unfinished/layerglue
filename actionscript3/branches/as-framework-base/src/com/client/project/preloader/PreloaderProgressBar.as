package com.client.project.preloader
{
	import com.layerglue.flash.preloader.FlashPreloadManager;
	import com.layerglue.lib.base.events.PreloadManagerEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	public class PreloaderProgressBar extends Sprite
	{
		
		public function PreloaderProgressBar(preloadManager:FlashPreloadManager)
		{
			super();
			
			_preloadManager = preloadManager;
			
			_preloadManager.addEventListener(ProgressEvent.PROGRESS, loadChangeHandler);
			_preloadManager.addEventListener(PreloadManagerEvent.INITIAL_ASSETS_LOAD_COMPLETE, loadChangeHandler);
			
			createChildren();
			draw();
		}
		
		private var _preloadManager:FlashPreloadManager;
		
		public function get preloadManager():FlashPreloadManager
		{
			return _preloadManager;
		}
		
		public function set preloadManager(value:FlashPreloadManager):void
		{
			_preloadManager = value;
		}
		
		private function loadChangeHandler(event:Event):void
		{
			draw();
		}
		
		protected function createChildren():void
		{
			
		}
		
		protected function draw():void
		{
			if(stage)
			{
				var amountLoaded:Number = _preloadManager.loadManager.currentValue / _preloadManager.loadManager.totalValue;
				
				var fixedWidth:Number = 200;
				var fixedHeight:Number = 20;
				
				graphics.beginFill(0x0000FF);
				graphics.drawRect(stage.stageWidth/2 - fixedWidth/2, stage.stageHeight/2 - fixedHeight/2, fixedWidth, fixedHeight);
				graphics.endFill();
								
				graphics.beginFill(0x00FF00);
				graphics.drawRect(stage.stageWidth/2 - fixedWidth/2, stage.stageHeight/2 - fixedHeight/2, fixedWidth*amountLoaded, fixedHeight);
				graphics.endFill();
			}
		}
		
	}
}