package com.layerglue.lib.base.events
{

	import com.layerglue.lib.base.core.IDestroyable;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * This class wraps the event listening functionality provided by the standard flashplayer event system.
	 * <p>A reference to the eventName, listener and useCapture properties is stored so the listener can be removed later</p>
	 */
	public class EventListener implements IDestroyable
	{
		
		private var _target:IEventDispatcher;
		
		/**
		 * The object to being listened to.
		 */
		public function get target():IEventDispatcher
		{
			return _target;
		}

		private var _eventName:String;
		
		/**
		 * The event string to listen for
		 */
		public function get eventName():String
		{
			return _eventName;
		}
				
		private var _listener:Function;
		
		/**
		 * The method to handle the event when it is dispatched.
		 */
		public function get listener():Function
		{
			return _listener;
		}
		
		private var _useCapture:Boolean;
		
		/**
		 * Whether or not the event should be handled in the capture phase.
		 */
		public function get useCapture():Boolean
		{
			return _useCapture;
		}
		
		private var _priority:int;
		
		/**
		 * The priority level of the event listener. See IEventDispatcher.addEventListener for more
		 * information.  
		 */
		public function get priority():int
		{
			return _priority;
		}
		
		private var _useWeakReference:Boolean;
		
		/**
		 * Whether or not to use weak referencing
		 */
		public function get useWeakReference():Boolean
		{
			return _useWeakReference;
		}
		
		private var _active:Boolean;

		public function get active():Boolean
		{
			return _active;
		}
		
		public function EventListener(	target:IEventDispatcher,
										eventName:String,
										listener:Function,
										useCapture:Boolean=false,
										priority:int=0,
										useWeakReference:Boolean=true,
										activateImmediately:Boolean=true)
		{
			super();
			
			_active = false;
			
			_target = target;
			_eventName = eventName;
			_listener = listener;
			_useCapture = useCapture;
			_priority = priority;
			_useWeakReference = useWeakReference;
			
			if(activateImmediately)
			{
				activate();
			}
		}
		
		/**
		 * Adds the event listener defined by the properties of this instance.
		 */
		public function activate():void
		{
			if(_target == null)
			{
				throw new Error("The target property for this listener is not defined for this EventListener instance");
			}
			
			if(_eventName == null)
			{
				throw new Error("The eventName property for this listener is not defined for this EventListener instance");
			}
			
			if( _listener == null)
			{
				throw new Error("The listener property for this listener is not defined for this EventListener instance");
			}
			
			if(!_active)
			{
				target.addEventListener(eventName, listener, useCapture, priority, useWeakReference);
				_active = true;
			}
		}
		
		/**
		 * Removes the event listener defined by the properties of this instance, but maintains
		 * properties and references allowing the listener to be reactivated at a point
		 * in the future.
		 */
		public function deactivate():void
		{
			if(_active)
			{
				target.removeEventListener(eventName, listener, useCapture);
				_active = false;
			}
		}
		
		/**
		 * Permanently deactivates the event listener and nulls properties with references to other
		 * objects.
		 * 
		 * <p>This method permanently prevents an instance from listening to an event again as it
		 * nulls the eventName and listener property, ensuring that referenced objects can be
		 * garbage collected.</p>
		 * 
		 * <p>If the listener is intended to be reactivated at some point in the future, deactivate
		 * should be used, as it maintains the references to eventName and listener.
		 * </p>
		 * 
		 * @see deactivate()
		 */
		public function destroy():void
		{
			deactivate();
			
			_target = null;
			_listener = null;
			_eventName = null;
		}	
	}
}