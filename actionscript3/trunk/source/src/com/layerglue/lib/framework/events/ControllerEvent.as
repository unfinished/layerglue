package com.layerglue.lib.framework.events
{
	import flash.events.Event;

	public class ControllerEvent extends Event
	{
		public static const READY:String = "ControllerEvent_ready";
		
		public function ControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}