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
	public interface ICollectionStrategy
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
		function addItem(collection:*, item:Object):void
		
		/**
		 * Adds an item to the colleciton at a specific location
		 * 
		 * @param collection The collection to add the item to.
		 * @param item The item to add to the collection.
		 * @param index The index at which to add the item.
		 */
		function addItemAt(collection:*,item:Object, index:int):void;
		
		 /**
		 * Returns an item at a specific index in the collection.
		 * 
		 * @param collection The collection to search through.
		 * @param index The index of the item to search for.
		 * 
		 * @returns The item at the specified index, or null if it doesnt exist.
		 */
		function getItemAt(collection:*,index:int, prefetch:int = 0):Object
		
		/**
		 * Returns the index of the specified item or -1 if it is not present.
		 * 
		 * @param The collection to search.
		 * 
		 * @returns The index of the specified item or -1 if it is not present. 
		 */
		function getItemIndex(collection:*,item:Object):int
		
		/**
		 * Removes the item at the specified index and returns it.
		 * 
		 * @param collection The collection from which to remove the item.
		 * @param index The index at which to remove the item.
		 * 
		 * @returns The item that has been removed or -1 if it cannot be found.
		 */
		function removeItemAt(collection:*,index:int):Object
		
		/**
		 * Removes the specified item and returns it.
		 * 
		 * @param collection The collection from which to remove the item
		 * @param item The item to remove.
		 * 
		 * @returns The item that was removed or null if it could not be found.
		 */
		function removeItem(collection:*,item:Object):Object
		
		/**
		 * Removes all items in the collection.
		 * 
		 * @param collection The collection to remove all items from.
		 */
		function removeAll(collection:*):void
		
		/**
		 * Whether or not the collection contains the specified item.
		 * 
		 * @param The collection to search.
		 * @param The item to search for.
		 * 
		 * @returns True if the item is found in the collection, or false if not.
		 */
		function contains(collection:*, item:Object):Boolean
		
		/**
		 * The number of items in the collection.
		 * 
		 * @param collection The collection to query.
		 * 
		 * @returns The number of items in the collection.
		 */
		function getLength(collection:*):int
	}
}