//package com.layerglue.lib.base.collections.strategies
package com.layerglue.lib.base.collections.strategies
{
	import com.layerglue.lib.base.collections.strategies.ICollectionStrategy;
	
	public class AbstractCollectionStrategy extends Object implements ICollectionStrategy
	{
		public function AbstractCollectionStrategy()
		{
			super();
		}
		
		private var _type:Class;
		
		public function get type():Class
		{
			return _type;
		}
		
		public function set type(value:Class):void
		{
			_type = value;
		}
		
		public function addItemAt(collection:*, item:Object, index:int):void
		{
			throw new Error("addItemAt() needs to be overriden in concrete implementations");
		}
		
		public function addItem(collection:*, item:Object):void
		{
			throw new Error("addItem() needs to be overriden in concrete implementations");
		}
		
		public function getItemAt(collection:*, index:int, prefetch:int = 0):Object
		{
			throw new Error("getItemAt() needs to be overriden in concrete implementations");
			return null;
		}
		
		public function getItemIndex(collection:*, item:Object):int
		{
			throw new Error("getItemIndex() needs to be overriden in concrete implementations");
			return null;
		}
		 
		public function removeItemAt(collection:*, index:int):Object
		{
			throw new Error("removeItemAt() needs to be overriden in concrete implementations");
			return null;
		}
				
		public function removeItem(collection:*, item:Object):Object
		{
			throw new Error("removeItem() needs to be overriden in concrete implementations");
			return null;
		}
		
		public function removeAll(collection:*):void
		{
			throw new Error("removeAll() needs to be overriden in concrete implementations");
		}
		 
		public function contains(collection:*, item:Object):Boolean
		{
			throw new Error("contains() needs to be overriden in concrete implementations");
			return null;
		}
		 
		public function getLength(collection:*):int
		{
			throw new Error("get length() needs to be overriden in concrete implementations");
			return NaN;
		}
	}
}