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
	dynamic public class ArrayExt extends Array implements ICollection
	{
		private var _strategy:ICollectionStrategy; 
		
		public function ArrayExt(source:Array=null)
		{
			super();
			
			_eventDispatcher = new EventDispatcher();
			
			_strategy = new ArrayStrategy();
		
			for each(var item:* in source)
			{
				addItem(item);
			}
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