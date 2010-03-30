package com.layerglue.lib.base.collections.strategies 
{

	/**
	 * @author Jamie Copeland
	 */
	public interface ISimpleCollectionStrategy 
	{
		/**
		 * The type of the underlying instance that can be mediated by this class.
		 * 
		 * @see ArrayStrategy
		 * @see ArrayCollection
		 */
		function get type():Class
		function set type(value:Class):void
		
		/**
		 * Adds an item to the end of the collection.
		 * 
		 * @param collection The collection to add the item to.
		 * @param item The item to add to the collection.
		 */
		function addItem(collection:Object, item:*):void
		
		/**
		 * Removes the specified item and returns it.
		 * 
		 * @param collection The collection from which to remove the item
		 * @param item The item to remove.
		 * 
		 * @returns The item that was removed or null if it could not be found.
		 */
		function removeItem(collection:Object, item:*):*
	}
}
