package com.layerglue.lib.base.utils 
{

	import flash.display.DisplayObject;
	/**
	 * @author Jamie Copeland
	 */
	public class PositionUtils extends Object 
	{
		public function PositionUtils()
		{
			super();
		}
		
		public static function stackVertical(anchor:DisplayObject, target:DisplayObject, padding:Number, matchX:Boolean=true, offSetX:Number=NaN):void
		{
			var anchorX:Number;
			var anchorY:Number;
			var anchorWidth:Number;
			var anchorHeight:Number;
			
			if(anchor)
			{
				anchorX = anchor.x;
				anchorY = anchor.y;
				anchorWidth = anchor.width;
				anchorHeight = anchor.height;
			}
			else
			{
				anchorX = 0;
				anchorY = 0;
				anchorWidth = 0;
				anchorHeight = 0;
			}
			
			//Set the x value of target
			if(matchX)
			{
				target.x = isNaN(offSetX) ? anchorX : anchorY + offSetX;
			}
			else
			{
				if(!isNaN(offSetX))
				{
					target.x = offSetX;
				}
			}
			
			//Set the y value of target
			target.y = anchorY + anchorHeight + padding;
		}
		
		public static function stackHorizontal(anchor:DisplayObject, target:DisplayObject, padding:Number, matchY:Boolean=true, offSetY:Number=NaN):void
		{
			var anchorX:Number;
			var anchorY:Number;
			var anchorWidth:Number;
			var anchorHeight:Number;
			
			if(anchor)
			{
				anchorX = anchor.x;
				anchorY = anchor.y;
				anchorWidth = anchor.width;
				anchorHeight = anchor.height;
			}
			else
			{
				anchorX = 0;
				anchorY = 0;
				anchorWidth = 0;
				anchorHeight = 0;
			}
			
			//Set the x value of target
			target.x = anchorX + anchorWidth + padding;
			
			//Set the y value of target
			if(matchY)
			{
				target.y = isNaN(offSetY) ? anchorY : anchorY + offSetY;
			}
			else
			{
				if(!isNaN(offSetY))
				{
					target.y = offSetY;
				}
			}
		}
		
		
		
	}
}
