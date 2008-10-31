package com.layerglue.lib.framework.events
{
	import flash.events.Event;

	public class NavigableApplicationControllerEvent extends Event
	{
		public static const CURRENT_ADDRESS_CHANGE:String = "currentAddressChange";
		public static const PREVIOUS_ADDRESS_CHANGE:String = "previousAddressChange";
		public static const NAVIGATION_COUNTER_CHANGE:String = "navigationCounterChange";	
		
		public function NavigableApplicationControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}