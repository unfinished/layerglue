package com.layerglue.lib.base.events
{
	import flash.events.Event;

	public class PreloaderViewEvent extends Event
	{
		public static const ANIMATION_COMPLETE:String = "PreloaderViewEvent_animationComplete";
		
		public function PreloaderViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new PreloaderViewEvent(type, bubbles, cancelable);
		}
	}
}