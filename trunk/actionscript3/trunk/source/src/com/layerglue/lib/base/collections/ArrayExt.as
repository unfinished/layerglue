package com.layerglue.lib.base.collections
{
	import com.layerglue.lib.base.collections.strategies.ArrayStrategy;
	import com.layerglue.lib.base.collections.strategies.ICollectionStrategy;
	
	/**
	 * A subclass of Array that implements the ICollection interface.
	 */
	//TODO Remove dynamicness when this changes to being a decorator
	dynamic public class ArrayExt extends Array implements ICollection
	{
		private var _strategy:ICollectionStrategy; 
		
		public function ArrayExt(numElements:int=0)
		{
			super(numElements);
			
			_strategy = new ArrayStrategy();
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItemAt(item:Object, index:int):void
		{
			_strategy.addItemAt(this, item, index);
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItem(item:Object):void
		{
			_strategy.addItem(this, item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemAt(index:int, prefetch:int=0):Object
		{
			return _strategy.getItemAt(this, index, prefetch);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemIndex(item:Object):int
		{
			return _strategy.getItemIndex(this, item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItemAt(index:int):Object
		{
			return _strategy.removeItemAt(this, index);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItem(item:Object):Object
		{
			return _strategy.removeItem(this, item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAll():void
		{
			_strategy.removeAll(this);
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains(item:Object):Boolean
		{
			return _strategy.contains(this, item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getLength():int
		{
			return _strategy.getLength(this);
		}
		
		
	}
}