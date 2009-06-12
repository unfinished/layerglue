package com.layerglue.lib.base.utils
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * @author LayerGlue
	 */
	public class ContainerUtils
	{
		/**
		 * Removes all children in a DisplayObjectContainer.
		 */
		public static function removeAllChildren(container:DisplayObjectContainer):void
		{
			while (container.numChildren > 0)
			{
				container.removeChildAt(0);
			}
		}
		
		/**
		 * Returns an array of children in a DisplayObjectContainer.
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