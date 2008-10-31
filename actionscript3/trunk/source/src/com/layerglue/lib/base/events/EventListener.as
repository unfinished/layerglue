package com.layerglue.lib.base.events
{

	import flash.events.IEventDispatcher;
	
	/**
	 * <p>This class wraps the event listening functionality provided by the standard flashplayer event system.</p>
	 * <p>A reference to the eventName, listener and useCapture properties is stored so the listener can be removed later</p>
	 */
	public class EventListener
	{
		
		private var _target:IEventDispatcher;
		
		/**
		 * The object to being listened to.
		 */
		public function get target():IEventDispatcher
		{
			return _target;
		}

		/*
		public function set target(value:IEventDispatcher):void
		{
			_target = value;
		}
		*/
		
		private var _eventName:String;
		
		/**
		 * The event string to listen for
		 */
		public function get eventName():String
		{
			return _eventName;
		}
		
		/*
		public function set eventName(value:String):void
		{
			_eventName = value;
		}
		*/
		
		private var _listener:Function;
		
		/**
		 * The method to handle the event when it is dispatched.
		 */
		public function get listener():Function
		{
			return _listener;
		}
		
		/*
		public function set listener(value:Function):void
		{
			_listener = value;
		}
		*/
		
		private var _useCapture:Boolean;
		
		/**
		 * Whether or not the event should be handled in the capture phase.
		 */
		public function get useCapture():Boolean
		{
			return _useCapture;
		}
		
		/*
		public function set useCapture(value:Boolean):void
		{
			_useCapture = value;
		}
		*/
		
		private var _priority:int;
		
		/**
		 * The priority level of the event listener. See IEventDispatcher.addEventListener for more
		 * information.  
		 */
		public function get priority():int
		{
			return _priority;
		}
		
		/*
		public function set priority(value:int):void
		{
			_priority = value;
		}
		*/
		
		private var _useWeakReference:Boolean;
		
		/**
		 * Whether or not to use weak referencing
		 */
		public function get useWeakReference():Boolean
		{
			return _useWeakReference;
		}
		
		/*
		public function set useWeakReference(value:Boolean):void
		{
			_useWeakReference = value;
		}
		*/
		
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
		 * Removes the event listener defined by the properties of this instance.
		 */
		public function remove():void
		{
			deactivate();
		}
		
		/**
		 * Adds the event listener defined by the properties of this instance.
		 */
		public function activate():void
		{
			if(!_active)
			{
				target.addEventListener(eventName, listener, useCapture, priority, useWeakReference);
				_active = true;
			}
		}
		
		/**
		 * Removes the event listener defined by the properties of this instance.
		 */
		public function deactivate():void
		{
			if(_active)
			{
				target.removeEventListener(eventName, listener, useCapture);
				_active = false;
			}
		}
	}
}