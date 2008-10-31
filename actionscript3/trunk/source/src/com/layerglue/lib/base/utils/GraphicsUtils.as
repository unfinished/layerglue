package com.layerglue.lib.base.utils
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	public class GraphicsUtils
	{
		/**
		 * Fills a sprite's dimensions with a colored rectangle. Useful for debugging purposes.
		 */
		static public function fillSprite(sprite:Sprite, color:Number = 0xFF0000, alpha:Number = 1):void
		{
			sprite.graphics.beginFill(color, alpha);
			sprite.graphics.drawRect(0, 0, sprite.width, sprite.height);
			sprite.graphics.endFill();
		}
		
		/**
		 * Draws a 2px dot at the 0,0 center-point of the sprite. Useful for debugging purposes.
		 */
		static public function drawCenterSpot(sprite:Sprite, color:Number = 0x00FF00, alpha:Number = 1):void
		{
			sprite.graphics.beginFill(color, alpha);
			sprite.graphics.drawRect(0, 0, 2, 2);
			sprite.graphics.endFill();
		}
		
		/**
		 * Returns distance in pixels between to points.
		 */
		static public function getDistance(p1:Point, p2:Point):Number
		{
			var a:Number = p1.x - p2.x;
			var b:Number = p1.y - p2.y;
			var c:Number = Math.sqrt(a*a+b*b);
			return c;
		}
		
		/**
		 * Sets the color of a DisplayObject.
		 */
		public static function setDisplayObjectColor(displayObject:DisplayObject, color:Number):void
		{
			var colorTransform:ColorTransform = displayObject.transform.colorTransform;
			colorTransform.color = color;
			displayObject.transform.colorTransform = colorTransform;
		}
		
		public static function setDisplayObjectBrightness(displayObject:DisplayObject, level:Number):void
		{
			var colorTransform:ColorTransform = displayObject.transform.colorTransform;
			colorTransform.redMultiplier = level;
			colorTransform.greenMultiplier = level;
			colorTransform.blueMultiplier = level;
			displayObject.transform.colorTransform = colorTransform;
		}
	}
}