package com.layerglue.lib.base.collections
{
	import flash.utils.Dictionary;

	/**
	 * An implementation of a HashMap, providing simple key value pair mappings.
	 */
	public class HashMap extends Object
	{
		protected var _dict:Dictionary;
		
		public function HashMap()
		{
			_dict = new Dictionary();
		}
		
		//TODO Look into making this private/protected
		public function get items():Dictionary
		{
			return _dict;
		}
		
		/**
		 * The value to which the specified key is mapped, or null if the map contains no mapping
		 * for this key.
		 */
		public function getValue(key:*):*
		{
			return _dict[key];
		}
		
		/**
		 * Associates the specified value with the specified key in this map.
		 */
		public function putValue(key:*, value:*):*
		{
			var oldValue:* = _dict[key];
			_dict[key] = value;
			return oldValue;
		}
		//TODO Look into what this is returning
		/**
		 * Removes the mapping for this key from this map if present.
		 */
		public function removeValue(key:*):*
		{
			if(containsKey(key));
			{
				delete _dict[key];
				return true;
			}
			return false;
		}
		
		/**
		 * Removes all mappings.
		 */
		public function removeAll():void
		{
			for(var key:String in _dict)
			{
				delete _dict[key];
			}
		}
		
		/**
		 * Whether this map contains no key-value mappings.
		 */
		public function isEmpty():Boolean
		{
			return size() == 0;
		}
		
		/**
		 * The number of key-value mappings in this map.
		 */
		public function size():int
		{
			var i:int = 0;
			var item:Object;
			for each(item in _dict)
			{
				i++;
			}
			return i;
		}
		
		/**
		 * A shallow clone of this hashmap instance.
		 */
		public function clone():HashMap
		{
			var clone:HashMap = new HashMap();
			var item:Object;
			
			for(item in _dict)
			{
				clone.putValue(item, getValue(item));
			}
			
			return clone;
		}
		
		/**
		 * Whether or not this instance contains the specified key.
		 * 
		 * @param key The key to test for
		 */
		public function containsKey(key:*):Boolean
		{
			for(var item:Object in _dict)
			{
				if(item == key)
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * Whether or not the this instance contains the specified value.
		 * 
		 * @param The value to test for
		 */
		public function containsValue(value:*):Boolean
		{
			var item:Object;
			var key:*;
			for(key in _dict)
			{
				if(value == getValue(key))
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * Removes all items from the map
		 */
		public function clear():void
		{
			var item:*;
			
			for(item in _dict)
			{
				removeValue(item);
			}
		}
	}
}