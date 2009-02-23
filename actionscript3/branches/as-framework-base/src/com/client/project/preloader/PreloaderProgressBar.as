package com.client.project.preloader
{
	import flash.display.Sprite;

	public class PreloaderProgressBar extends Sprite
	{
		public function PreloaderProgressBar()
		{
			super();
			
			createChildren();
			draw();
		}
		
		protected function createChildren():void
		{
			
		}
		
		protected function draw():void
		{
			graphics.beginFill(0x0000FF);
			graphics.drawRect(100, 100, 200, 30);
			graphics.endFill();
		}
		
		
		
		
	}
}