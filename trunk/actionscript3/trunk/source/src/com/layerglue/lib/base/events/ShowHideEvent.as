package com.layerglue.lib.base.events
{
	import flash.events.Event;

	public class ShowHideEvent extends Event
	{
		public static const SHOW_START:String = "showStart";
		public static const SHOW_STOP:String = "showStop";
		public static const SHOW_END:String = "showEnd";
		
		public static const HIDE_START:String = "hideStart";
		public static const HIDE_STOP:String = "hideStop";
		public static const HIDE_END:String = "hideEnd";
		
		public function ShowHideEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ShowHideEvent(type, bubbles, cancelable);
		}
	}
}