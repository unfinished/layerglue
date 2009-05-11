package com.layerglue.lib.base.collections
{
	import com.layerglue.lib.application.events.CollectionEvent;
	import com.layerglue.lib.application.events.CollectionEventKind;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * A subclass of Array that implements the ICollection interface.
	 */
	//TODO Remove dynamicness when this changes to being a decorator
	dynamic public class ArrayExt extends Array implements ICollection
	{
		
		public function ArrayExt(source:Array=null)
		{
			super();
			
			_eventDispatcher = new EventDispatcher();
			
			for each(var item:* in source)
			{
				addItem(item);
			}
		}
		
		////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function addItemAt(item:Object, index:int):void
		{
			splice(index, 0, item);
			
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
			push(item);
			
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
			return this[index];
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItemIndex(item:Object):int
		{
			return indexOf(item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItemAt(index:int):Object
		{
			var removedItem:Object = splice(index, 1);
			
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
			for(var i:int=length ; i>=0 ; i--)
			{
				removeItemAt(i);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains(item:Object):Boolean
		{
			return indexOf(item) != -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getLength():int
		{
			return length;
		}
		
		////////////////////////////////////
		
		// Implementation of IEventDispatcher ------------------------------------------------------
		
		private var _eventDispatcher:EventDispatcher;
		
		public function addEventListener(
				type:String, listener:Function,
				useCapture:Boolean=false,
				priority:int=0.0,
				useWeakReference:Boolean=false):void
		{
			_eventDispatcher.addEventListener(type, listener,useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return _eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return _eventDispatcher.willTrigger(type);
		}
		
	}
}