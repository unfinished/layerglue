package com.layerglue.lib.application.events
{
	import flash.events.Event;

	public class FrameworkTransitionEvent extends Event
	{
		public static const TRANSITION_IN_START:String = "transitionInStart";
		public static const TRANSITION_IN_STOP:String = "transitionInStop";
		public static const TRANSITION_IN_COMPLETE:String = "transitionInComplete";
		
		public static const TRANSITION_OUT_START:String = "transitionOutStart";
		public static const TRANSITION_OUT_STOP:String = "transitionOutStop";
		public static const TRANSITION_OUT_COMPLETE:String = "transitionOutComplete";
		
		public function FrameworkTransitionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}