package com.layerglue.lib.base.utils
{
	import flash.display.DisplayObject;
	
	public class SizeUtils
	{
		public static const WIDTH:String = "width";
		public static const HEIGHT:String = "height";
		
		public function SizeUtils()
		{
		}
		
		public static function getLargestItem(dimension:String, items:Array):DisplayObject
		{
			var largestItem:DisplayObject
			var i:int=0;
			while(i<items.length)
			{
				var item:DisplayObject = items[i];
				
				if(largestItem == null || item[dimension] > largestItem[dimension])
				{
					largestItem = item;
				}
				i++;
			}
			
			return largestItem;
		}

	}
}