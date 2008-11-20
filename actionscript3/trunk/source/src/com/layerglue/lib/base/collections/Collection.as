package com.layerglue.lib.base.collections
{
	import com.layerglue.lib.base.collections.strategies.ArrayStrategy;
	import com.layerglue.lib.base.collections.strategies.ICollectionStrategy;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.layerglue.lib.application.events.CollectionEvent;
	import com.layerglue.lib.application.events.CollectionEventKind;
	
	/**
	 * A subclass of Array that implements the ICollection interface.
	 */
	//TODO Remove dynamicness when this changes to being a decorator
	public class Collection extends EventDispatcher implements ICollection
	{
		private var _strategy:ICollectionStrategy; 
		private var _array:Array;
		
		public function Collection(source:Array=null)
		{
			super();
			
			_array = source ? source : new Array();
			_strategy = new ArrayStrategy();
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItemAt(item:Object, index:int):void
		{
			_strategy.addItemAt(_array, item, index);
			
			var e:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
			e.kind = CollectionEventKind.ADD;
			e.items = [item];
			e.location = index;
			dispatchEvent(e);
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItem(item:Object):void
		{
			_strategy.addItem(_array, item);
			
			var e:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
			e.kind = CollectionEventKind.ADD;
			e.items = [item];
			e.location = length-1;
			dispatchEvent(e);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemAt(index:int, prefetch:int=0):Object
		{
			return _array[index];
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
			var removedItem = _strategy.removeItemAt(_array, index);
			
			if(removedItem != null)
			{
				var e:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
				e.kind = CollectionEventKind.ADD;
				e.items = [item];
				e.location = index;
				dispatchEvent(e);
			}
			
			return _strategy.removeItemAt(_array, index);
		}
		
		/**
		 * @inheritDoc
		 */
		/*
		public function removeItem(item:Object):Object
		{
			return _strategy.removeItem(_array, item);
		}
		*/
		
		/**
		 * @inheritDoc
		 */
		public function removeAll():void
		{
			for each(var i:int=_array.length ; i>=0 ; i--)
			{
				var item:Object = _array[i];
				removeItemAt(i);
			}
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