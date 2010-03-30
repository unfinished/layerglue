package com.layerglue.lib.base.collections.strategies
{
	/**
	 * Redefines the methods specified in ICollection as a utility, allowing the manipulation of a
	 * collection without it having to directly implement ICollection.
	 * 
	 * <p>This interface should be used to mediate interaction with collection instances where
	 * ICollection cannot be implemented by the instance itself. For example Array and
	 * ArrayCollection both perform similar tasks as collections, but have a different API. This
	 * interface is implemented by ArrayStrategy and ArrayCollectionStrategy to allow a higher level
	 * system to have a standardised way of manipulating either collection regardless of its type.</p> 
	 */
	public interface ICollectionStrategy extends ISimpleCollectionStrategy
	{
		
		/**
		 * Adds an item to the colleciton at a specific location
		 * 
		 * @param collection The collection to add the item to.
		 * @param item The item to add to the collection.
		 * @param index The index at which to add the item.
		 */
		function addItemAt(collection:Object,item:*, index:int):void;
		
		 /**
		 * Returns an item at a specific index in the collection.
		 * 
		 * @param collection The collection to search through.
		 * @param index The index of the item to search for.
		 * 
		 * @returns The item at the specified index, or null if it doesnt exist.
		 */
		function getItemAt(collection:Object,index:int, prefetch:int = 0):*
		
		/**
		 * Returns the index of the specified item or -1 if it is not present.
		 * 
		 * @param The collection to search.
		 * 
		 * @returns The index of the specified item or -1 if it is not present. 
		 */
		function getItemIndex(collection:Object,item:*):int
		
		/**
		 * Removes the item at the specified index and returns it.
		 * 
		 * @param collection The collection from which to remove the item.
		 * @param index The index at which to remove the item.
		 * 
		 * @returns The item that has been removed or -1 if it cannot be found.
		 */
		function removeItemAt(collection:Object,index:int):*
		
		/**
		 * Removes all items in the collection.
		 * 
		 * @param collection The collection to remove all items from.
		 */
		function removeAll(collection:Object):void
		
		/**
		 * Whether or not the collection contains the specified item.
		 * 
		 * @param The collection to search.
		 * @param The item to search for.
		 * 
		 * @returns True if the item is found in the collection, or false if not.
		 */
		function contains(collection:Object, item:*):Boolean
		
		/**
		 * The number of items in the collection.
		 * 
		 * @param collection The collection to query.
		 * 
		 * @returns The number of items in the collection.
		 */
		function getLength(collection:Object):int
	}
}