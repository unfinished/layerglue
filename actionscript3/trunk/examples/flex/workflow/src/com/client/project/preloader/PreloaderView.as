package com.client.project.preloader
{
	import com.layerglue.flex3.base.preloader.AbstractPreloaderView;
	import flash.events.ProgressEvent;

	public class PreloaderView extends AbstractPreloaderView
	{
		public function PreloaderView()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			//trace("initialized: " + stage);
			
			graphics.beginFill(0x00FF00, 1);
			graphics.drawCircle(stageWidth/2, stageHeight/2, 200);
			graphics.endFill();
		}
		
		override protected function progressHandler(event:ProgressEvent):void
		{
			trace("progress: " + event.bytesLoaded);
		}
		
		
	}
}