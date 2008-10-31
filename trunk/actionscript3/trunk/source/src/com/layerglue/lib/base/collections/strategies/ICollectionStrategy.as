package com.layerglue.lib.base.collections.strategies
{
	/**
	 * Defines the methods necessary to manipulate the properties of in ICollection instance.
	 */
	public interface ICollectionStrategy
	{
		function get type():Class
		function set type(value:Class):void
		
		function addItemAt(collection:*,item:Object, index:int):void;
		function addItem(collection:*, item:Object):void
		 
		function getItemAt(collection:*,index:int, prefetch:int = 0):Object
		function getItemIndex(collection:*,item:Object):int
		 
		function removeItemAt(collection:*,index:int):Object
		function removeItem(collection:*,item:Object):Object
		function removeAll(collection:*):void
		 
		function contains(collection:*, item:Object):Boolean
		
		function getLength(collection:*):int
	}
}