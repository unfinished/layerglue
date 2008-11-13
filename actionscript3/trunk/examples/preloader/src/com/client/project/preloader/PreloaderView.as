package com.client.project.preloader
{
	import com.layerglue.flex3.base.preloader.AbstractPreloaderDisplay;
	import com.layerglue.flex3.base.preloader.PreloadManager;
	import com.layerglue.lib.base.io.LoadManager;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	import com.layerglue.lib.base.loaders.RootLoaderProxy;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class PreloaderView extends AbstractPreloaderDisplay
	{
		private var _progressBar:Sprite;
		private var _barWidth:Number;
		private var _barHeight:Number;
		private var _barBorderThickness:Number;
		
		public function PreloaderView()
		{
			super();
			
			_barWidth = 500;
			_barHeight = 10;
			_barBorderThickness = 1;
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			createChildren();
			drawProgress();
			reposition();
		}
		
		override protected function loaderChangeHandler(event:Event):void
		{
			drawProgress();
		}
		
		override protected function stageSizeChangeHandler(event:Event):void
		{
			reposition();
		}
		
		protected function createChildren():void
		{
			_progressBar = new Sprite();
			addChild(_progressBar);
		}
		
		private function drawProgress():void
		{
			if(_progressBar)
			{
				_progressBar.graphics.beginFill(0x666666, 1);
				_progressBar.graphics.drawRect(0, 0, _barWidth, _barHeight);
				_progressBar.graphics.endFill()
				
				var loadManager:LoadManager = PreloadManager.getInstance().initialLoadManager;
				
				if(loadManager is ProportionalLoadManager)
				{
					_progressBar.graphics.beginFill(0xCCCCCC, 1);
					_progressBar.graphics.drawRect(_barBorderThickness, _barBorderThickness, (_barWidth-(_barBorderThickness*2)) * (loadManager as ProportionalLoadManager).currentValue, (_barHeight-(_barBorderThickness*2)));
					_progressBar.graphics.endFill()
				}
			}
		}
		
		private function reposition():void
		{
			if(_progressBar)
			{
				_progressBar.x = Math.round(stageWidth/2 - _progressBar.width/2);
				_progressBar.y = Math.round(stageHeight/2 - _progressBar.height/2);
			}
		}
	}
}