package com.layerglue.flex3.base.events
{
	import flash.events.Event;

	public class PreloadManagerEvent extends Event
	{
		public static const APPLICATION_LOAD_COMPLETE:String = "applicationLoadComplete";
		public static const APPLICATION_INIT_COMPLETE:String = "applicationInitComplete";
		public static const ASSETS_LOAD_COMPLETE:String = "loadManagerComplete";
		
		public function PreloadManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}