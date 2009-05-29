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
		
		public static function stackAgainstVerticalAnchor(target:DisplayObject, anchor:DisplayObject, padding:Number, matchX:Boolean=true, offSetX:Number=NaN):void
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
		
		public static function stackAgainstHorizontalAnchor(target:DisplayObject, anchor:DisplayObject, padding:Number, matchY:Boolean=true, offSetY:Number=NaN):void
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
		
		public static function stackHorizontal(x:Number, y:Number, horizontalGap:Number, items:Array):Number
		{
			var item:*;
			var xIncrementer:Number = x;
			
			var i:int=0;
			while(i<items.length)
			{
				item = items[i];
				
				//Dont try to do anything if a null value is passed to avoid errors
				if(item != null)
				{
					if(item is DisplayObject)
					{
						item.x = xIncrementer;
						
						if(!isNaN(y))
						{
							item.y = y;
						}
						
						xIncrementer += item.width + horizontalGap;
					}
					else if(item is Number)
					{
						xIncrementer = (xIncrementer - horizontalGap) + item;
					}
					else
					{
						throw new Error("Only DisplayObjects or Numbers can be added as items to PositionUtils.stackVertical");
					}
				}
				i++;
			}
			
			return item.y + item.height;
		}
		
		public static function stackVertical(x:Number, y:Number, verticalGap:Number, items:Array):Number
		{
			var item:*;
			var yIncrementer:Number = y;
			
			var i:int=0;
			while(i<items.length)
			{
				item = items[i];
				
				//Dont try to do anything if a null value is passed to avoid errors
				if(item != null)
				{
					if(item is DisplayObject)
					{
						if(!isNaN(x))
						{
							item.x = x;
						}
						
						item.y = yIncrementer;
						yIncrementer += item.height + verticalGap;
					}
					else if(item is Number)
					{
						yIncrementer = (yIncrementer - verticalGap) + item;
					}
					else
					{
						throw new Error("Only DisplayObjects or Numbers can be added as items to PositionUtils.stackVertical");
					}
				}
				i++;
			}
			
			return item.y + item.height;
		}
		
	}
}
