package com.layerglue.lib.base.utils
{
	
	public class ArrayUtils extends Object
	{
		public function ArrayUtils()
		{
			super();
		}
		
		/**
		 * Returns whether or not the array contains an item.
		 */
		static public function contains( array:Array, item:Object ):Boolean
		{
			var i:int = 0;
			
			for(i ; i < array.length; i++ )
			{
				if( array[i] === item )
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * Adds an item to the array
		 */
		public static function addItem(array:Array, item:*):void
		{
			array.push(item);
		}
		
		/**
		 * Adds an item to the array at a specified index
		 */
		public static function addItemAt(array:Array, item:*, index:int):void
		{
			array.splice(index, 0, item);
		}
		
		/**
		 * Removes an item from the array if it is present.
		 */
		public static function removeItem(array:Array, item:*):void
		{
			var i:int = 0;
			
			for(i ; i < array.length; i++ )
			{
				if( array[i] === item )
				{
					array.splice(i, 1);
				}
			}
		}
		
		/**
		 * Removes an item from the array at specified index
		 */
		public static function removeItemAt(array:Array, index:int):void
		{
			array.splice(index, 1);
		}
		
		/**
		 * Removes multiple items from the array.
		 */
		public static function removeItems(array:Array, items:Array):void
		{
			var item:*;
			for each(item in items)
			{
				removeItem(array, item);
			}
		}
		
		/**
		 * Removes all items from the array.
		 */
		public static function removeAllItems(array:Array):void
		{
			array.splice(0, array.length);
		}
		
		/**
		 * Returns a shallow clone of the array.
		 */
		public static function clone(array:Array):Array
		{
			var arr:Array = new Array();
			var item:*;
			
			for each(item in array)
			{
				arr.push(item);
			}
			
			return arr;
		}
		
		/**
		 * Returns an item whos property (identified by propertyName) is equal to value
		 * 
		 * <code>
		 * 
		 * var arr:Array = [ {id:123, name:"hello"}, {id:456, name:"goodbye"} ];
		 * var obj:Object = ArrayUtils.getItemByPropertyName(arr, "name", "goodbye");
		 * //obj will be set to the second item in the array
		 * 
		 * <code>
		 */
		public static function getItemByPropertyName(array:Array, propertyName:String, value:*):*
		{
			var item:*;
			
			for each(item in array)
			{
				if(item[propertyName] == value){
					return item;
				}
			}
			
			return null;
		}
		
		/**
		 * Returns an item at a specified index
		 */
		public static function getItemAtIndex(array:Array, index:int):*
		{
			return array[index];
		}
		
		/**
		 * Returns the index of the first appearance of the item in the array
		 */
		public static function getIndex(array:Array, item:*):int
		{
			var i:int = 0;
			
			for(i ; i < array.length; i++ )
			{
				if( array[i] === item )
				{
					return i;
				}
			}
			
			return -1;
		}
	}
}