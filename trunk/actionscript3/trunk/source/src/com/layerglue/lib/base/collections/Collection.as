package com.layerglue.lib.base.collections
{
	import com.layerglue.lib.base.collections.strategies.ArrayStrategy;
	import com.layerglue.lib.base.collections.strategies.ICollectionStrategy;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * A subclass of Array that implements the ICollection interface.
	 */
	//TODO Remove dynamicness when this changes to being a decorator
	public class Collection extends EventDispatcher implements ICollection
	{
		private var _strategy:ICollectionStrategy; 
		private var _array:Array;
		
		public function Collection(numElements:int=0)
		{
			super();
			
			_array = new Array(numElements);
			_strategy = new ArrayStrategy();
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItemAt(item:Object, index:int):void
		{
			_strategy.addItemAt(_array, item, index);
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItem(item:Object):void
		{
			_strategy.addItem(_array, item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemAt(index:int, prefetch:int=0):Object
		{
			return _strategy.getItemAt(_array, index, prefetch);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemIndex(item:Object):int
		{
			return _strategy.getItemIndex(_array, item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItemAt(index:int):Object
		{
			return _strategy.removeItemAt(_array, index);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItem(item:Object):Object
		{
			return _strategy.removeItem(_array, item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAll():void
		{
			_strategy.removeAll(_array);
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains(item:Object):Boolean
		{
			return _strategy.contains(_array, item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getLength():int
		{
			return _strategy.getLength(_array);
		}
	}
}