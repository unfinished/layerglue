package com.layerglue.lib.base.collections.strategies
{
	import com.layerglue.lib.base.collections.strategies.ICollectionStrategy;

	/**
	 * 
	 */
	public class AbstractCollectionStrategy extends Object implements ICollectionStrategy
	{
		public function AbstractCollectionStrategy()
		{
			super();
		}
		
		private var _type:Class;
		
		/**
		 * @inheritDoc
		 */
		public function get type():Class
		{
			return _type;
		}
		
		public function set type(value:Class):void
		{
			_type = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItem(collection:Object, item:*):void
		{
			throw new Error("addItem() needs to be overriden in concrete implementations");
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItemAt(collection:Object, item:*, index:int):void
		{
			throw new Error("addItemAt() needs to be overriden in concrete implementations");
		}
				
		/**
		 * @inheritDoc
		 */
		public function getItemAt(collection:Object, index:int, prefetch:int = 0):*
		{
			throw new Error("getItemAt() needs to be overriden in concrete implementations");
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemIndex(collection:Object, item:*):int
		{
			throw new Error("getItemIndex() needs to be overriden in concrete implementations");
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItemAt(collection:Object, index:int):*
		{
			throw new Error("removeItemAt() needs to be overriden in concrete implementations");
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItem(collection:Object, item:*):*
		{
			throw new Error("removeItem() needs to be overriden in concrete implementations");
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAll(collection:Object):void
		{
			throw new Error("removeAll() needs to be overriden in concrete implementations");
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains(collection:Object, item:*):Boolean
		{
			throw new Error("contains() needs to be overriden in concrete implementations");
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getLength(collection:Object):int
		{
			throw new Error("get length() needs to be overriden in concrete implementations");
			return NaN;
		}
	}
}