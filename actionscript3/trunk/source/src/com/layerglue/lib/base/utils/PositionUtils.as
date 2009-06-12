package com.layerglue.lib.base.utils 
{

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * @author Jamie Copeland
	 */
	public class PositionUtils extends Object 
	{
		public static const ALIGN_NONE:String = "none";
		public static const ALIGN_LEFT:String = "left";
		public static const ALIGN_RIGHT:String = "right";
		public static const ALIGN_CENTER:String = "center";
		public static const ALIGN_TOP:String = "top";
		public static const ALIGN_BOTTOM:String = "bottom";
		public static const ALIGN_MIDDLE:String = "middle";
		
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
		
		
		
		public static function stackHorizontal(items:Array, horizontalGap:Number, alignment:String=ALIGN_NONE, x:Number=0, y:Number=0, roundValues:Boolean=true):Number
		{
			var item:*;
			var xIncrementer:Number = x;
			if (roundValues)
			{
				xIncrementer = Math.round(xIncrementer);
			}
			
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
				
				if (roundValues)
				{
					xIncrementer = Math.round(xIncrementer);
				}
				i++;
			}
			
			if(alignment != ALIGN_NONE)
			{
				i=0;
				while(i<items.length)
				{
					if(items[i] is DisplayObject)
					{
						var obj:DisplayObject = items[i] as DisplayObject;
						
						switch(alignment)
						{
							case ALIGN_TOP:
								obj.y = y;
							break;
							
							case ALIGN_BOTTOM:
								obj.y = y - obj.height
							break;
							
							case ALIGN_MIDDLE:
								obj.y = y - (obj.height / 2);
							break;
						}
					}
					
					i++;
				}
			}
			
			return item.y + item.height;
		}
		
		
		public static function stackVertical(items:Array, verticalGap:Number, alignment:String=ALIGN_NONE, x:Number=0, y:Number=0, roundValues:Boolean=true):Number
		{
			var item:*;
			var widestItemWidth:Number;
			var yIncrementer:Number = y;
			if (roundValues)
			{
				yIncrementer = Math.round(yIncrementer);
			}
				
			var i:int=0;
			while(i<items.length)
			{
				item = items[i];
				
				//Dont try to do anything if a null value is passed to avoid errors
				if(item != null)
				{
					if(item is DisplayObject)
					{
						if( isNaN(widestItemWidth) || (item as DisplayObject).width > widestItemWidth )
						{
							widestItemWidth = (item as DisplayObject).width;
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
				
				if (roundValues)
				{
					yIncrementer = Math.round(yIncrementer);
				}
				i++;
			}
			
			if(alignment != ALIGN_NONE)
			{
				i=0;
				while(i<items.length)
				{
					if(items[i] is DisplayObject)
					{
						var obj:DisplayObject = items[i] as DisplayObject;
						
						switch(alignment)
						{
							case ALIGN_LEFT:
								obj.x = x;
							break;
							
							case ALIGN_RIGHT:
								obj.x = x - obj.width
							break;
							
							case ALIGN_CENTER:
								obj.x = x - (obj.width / 2);
							break;
						}
					}
					
					i++;
				}
			}
			
			return item.y + item.height;
		}
		
		public static function centerHorizontallyWithinObject(obj:DisplayObject, container:DisplayObject, offset:Number=0):void
		{
			obj.x = ((container.width / 2) - (obj.width / 2)) + offset;
		}
		
		public static function centerVerticallyWithinObject(obj:DisplayObject, container:DisplayObject, offset:Number=0):void
		{
			obj.y = ((container.height / 2) - (obj.height / 2)) + offset;
		}
		
		/**
		 * Returns references to all children of a DisplayObjectContainer in an array.
		 */
		public static function getChildrenInContainer(container:DisplayObjectContainer):Array
		{
			var a:Array = new Array();
			for (var i:int = 0; i < container.numChildren; i++)
			{
				a.push(container.getChildAt(i));
			}
			return a;
		}
	}
}
