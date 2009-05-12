package com.layerglue.lib.base.utils
{
	import flash.display.Sprite;
	
	public class GraphicUtils extends Object
	{
		public function GraphicUtils()
		{
			super();
		}
		
		public static function fillSprite(sprite:Sprite, color:Number=0x00FF00, alpha:Number=0.5, width:Number=NaN, height:Number=NaN):void
		{
			if(isNaN(width))
			{
				width = sprite.width;
			}
			
			if(isNaN(height))
			{
				height = sprite.height;
			}
			
			sprite.graphics.clear();
			sprite.graphics.beginFill(color, alpha);
			sprite.graphics.drawRect(0, 0, width, height);
			sprite.graphics.endFill();
		}
	}
}