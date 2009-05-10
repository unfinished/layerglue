package com.layerglue.flex3.base.controls
{
	import flash.display.Bitmap;
	
	import mx.controls.Image;

	public class SmoothImage extends Image
	{
		public function SmoothImage()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(content is Bitmap)
			{
				var bmp:Bitmap = Bitmap(content);
				if(bmp && bmp.smoothing == false)
				{
					bmp.smoothing = true;
				}
			}
		}
	}
}