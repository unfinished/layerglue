package com.layerglue.lib.base.collections
{
	public class ArrayWrapperExtension extends ArrayWrapper
	{
		public function ArrayWrapperExtension(...rest)
		{
			super(rest);
		}
		
		/**
		 * Removes an item from the array.
		 * 
		 * @returns Whether or not the item was removed
		 */
		public function removeItemAt(index:int):Boolean
		{
			return splice(index, 1).length > 0;
		}
	}
}