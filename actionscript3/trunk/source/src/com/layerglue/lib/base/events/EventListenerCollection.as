package com.layerglue.lib.base.events
{
	import com.layerglue.lib.base.events.EventListener;
	import com.layerglue.lib.base.utils.ArrayUtils;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * A collection of EventListener instances that can be added or removed at the same time.
	 */
	public class EventListenerCollection 
	{
		protected var _eventListeners:Array;
		
		public function EventListenerCollection()
		{
			super();
			
			_eventListeners = [];
		}
		
		/**
		 * Creates a new listener instance in the collection
		 */
		public function createListener(target:IEventDispatcher, eventName:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=true, activateImmediately:Boolean=true):EventListener
		{
			var eventListener:EventListener = new EventListener(target, eventName, listener, useCapture, priority, useWeakReference, activateImmediately);
			addItem(eventListener);
			return eventListener;
		}
		
		/**
		 * Adds an EventListener instance to the collection.
		 * 
		 * @param eventListener The Eventlistener instance to be added.
		 */
		public function addItem(eventListener:EventListener):void
		{
			_eventListeners.push(eventListener);	
		}
		
		/**
		 * Removes an event listener from the collection.
		 * <p>By default the remove() method is called on the listener instance being removed, but
		 * this can be suppressed by setting the dontDeactivate parameter to true.</p>
		 * 
		 * @param eventListener The EventListener instance to remove from the collection.
		 * @param dontDeactivate Whether or not to deactivate the EventListener instance as it is removed
		 */
		public function removeItem(eventListener:EventListener, dontDeactivate:Boolean=false):void
		{
			ArrayUtils.removeItem(_eventListeners, eventListener);
		}
		
		/**
		 * Activates all the listeners in the collection.
		 */
		public function activateAll():void
		{
			var eventListener:EventListener;
			
			for each(eventListener in _eventListeners)
			{
				eventListener.activate();
			}
		}
		
		/**
		 * Deactivates all the listeners in the collection.
		 */
		public function deactivateAll():void
		{
			var eventListener:EventListener;
			
			for each(eventListener in _eventListeners)
			{
				eventListener.deactivate();
			}
		}
		
		/**
		 * Removes all the listeners from the collection.
		 */
		public function removeAll(dontDeactivate:Boolean=false):void
		{
			if(!dontDeactivate)
			{
				deactivateAll();
			}
			
			ArrayUtils.removeAllItems(_eventListeners);
		}
		
		/**
		 * Whether all the items in the collection are active.
		 */
		public function get allItemsAreActive():Boolean
		{
			var eventListener:EventListener;
			
			if(_eventListeners.length > 0)
			{
				for each(eventListener in _eventListeners)
				{
					if(!eventListener.active)
					{
						return false;
					}
				}
				
				return true;
			}
			
			return false;
		}
		
		/**
		 * Whether all the items in the collection are inactive.
		 */
		public function get allItemsAreInactive():Boolean
		{
			var eventListener:EventListener;
			
			if(_eventListeners.length > 0)
			{
				for each(eventListener in _eventListeners)
				{
					if(eventListener.active)
					{
						return false;
					}
				}
				
				return true;
			}
			
			return false;
		}
		
		/**
		 * Whether or not this instance contains the specified EventListener.
		 * 
		 * @param eventListener The Eventlistener instance to test for
		 * @param findSimilar Whether to search for EventListeners that have the same properties as the specified instance, but are not that that instance. 
		 */
		public function contains(eventListener:EventListener, findSimilar:Boolean=false):Boolean
		{
			if(findSimilar)
			{
				var el:EventListener;
			
				for each(el in _eventListeners)
				{
					if(
						el.target == eventListener.target 
						&&
						el.eventName == eventListener.eventName 
						&&
						el.useCapture == eventListener.useCapture 
						&&
						el.priority == eventListener.priority 
						&&
						el.useWeakReference == eventListener.useWeakReference
						)
					{
						return true;
					}
				}
			}
			else
			{
				return ArrayUtils.contains(_eventListeners,  eventListener);
			}
			
			return false;
		}
		
		/**
		 * Proxies a call on to removeAll()
		 */
		public function destroy():void
		{
			removeAll();
		}
	}
}