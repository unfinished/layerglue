package com.layerglue.lib.base.collections
{
	import com.layerglue.lib.application.events.CollectionEvent;
	import com.layerglue.lib.application.events.CollectionEventKind;
	
	import flash.events.EventDispatcher;
	
	/**
	 * A subclass of Array that implements the ICollection interface.
	 */
	//TODO Remove dynamicness when this changes to being a decorator
	public class Collection extends EventDispatcher implements ICollection
	{
		private var _array:Array;
		
		public function Collection(source:Array=null)
		{
			super();
			
			_array = source ? source : new Array();
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItemAt(item:Object, index:int):void
		{
			_array.splice(index, 0, item);
			
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
			_array.push(item);
			
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
			return _array.indexOf(item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItemAt(index:int):Object
		{
			var removedItem:Object = _array.splice(index, 1);
			
			if(removedItem != null)
			{
				var e:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
				e.kind = CollectionEventKind.REMOVE;
				e.items = [removedItem];
				e.location = index;
				dispatchEvent(e);
			}
			
			return removedItem;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAll():void
		{
			for(var i:int=_array.length ; i>=0 ; i--)
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
			return _array.indexOf(item) != -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getLength():int
		{
			return _array.length;
		}
	}
}