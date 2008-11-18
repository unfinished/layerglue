package com.layerglue.lib.base.collections
{
	import flash.events.IEventDispatcher;
	
	//TODO Look into return types for failed queries or removes - null or -1 etc
	/**
	 * Defines common methods and properties associated with collections.
	 * 
	 * <p>ICollection is designed to allow different classes such as Array and ArrayCollection to
	 * be subclassed, implement a common interface, and be used interchangeabley.</p>
	 */
	public interface ICollection extends IEventDispatcher
	{
		/**
		 * Adds an item to the end of collection.
		 */
		 function addItem(item:Object):void
		 
		 /**
		 * Adds an item at a specific location in the collection.
		 */
		 function addItemAt(item:Object, index:int):void;
		 
		 //TODO Look at standardising the return value if the item is not present - currently in
		 //Array a null value is passed whereas ArrayCollection retuns -1
		 /**
		 * Returns the item at a specific location in the collection.
		 * 
		 * @param index The index of the item to return.
		 */
		 function getItemAt(index:int, prefetch:int = 0):Object
		 
		 /**
		 * Returns the index of an item if it is present in the Collection
		 */
		 function getItemIndex(item:Object):int
		 
		 /**
		 * Removes an item at a specific index in the collection.
		 * 
		 * @param index The index of the item to remove.
		 */
		 function removeItemAt(index:int):Object
		 
		 /**
		 * Removes an item from the collection if it is present.
		 * 
		 * @param The item to be removed.
		 * 
		 * @returns The item that has been removed.
		 */
		 function removeItem(item:Object):Object
		 
		 /**
		 * Removes all items from the collection.
		 */
		 function removeAll():void
		 
		 /**
		 * Whether or not the collection contains the specified item
		 * 
		 * @param item The item to be tested for,
		 */
		 function contains(item:Object):Boolean
		 
		 /**
		 * How many items are in the array.
		 */
		 //TODO: This should change to length once ArrayExt is a decorator instead of an subclass of Array
		 function getLength():int
	}
}