package com.layerglue.lib.base.collections 
{

	/**
	 * @author Jamie Copeland
	 */
	public interface ISimpleCollection 
	{
		/**
		 * Adds an item to the end of collection.
		 */
		 function addItem(item:*):void
		 
		 /**
		 * Removes an item from the collection if it is present.
		 * 
		 * @param The item to be removed.
		 * 
		 * @returns The item that has been removed.
		 */
		 function removeItem(item:*):*
	}
}
