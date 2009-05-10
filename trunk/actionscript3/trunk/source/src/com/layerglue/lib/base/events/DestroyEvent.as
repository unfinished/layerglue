package com.layerglue.lib.base.events
{
	import flash.events.Event;

	/**
	 * An event that should be used to express when an object is being destroyed.
	 */
	public class DestroyEvent extends Event
	{
		public static const DESTROY:String = "destroyEvent_destroy";
		
		public function DestroyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}