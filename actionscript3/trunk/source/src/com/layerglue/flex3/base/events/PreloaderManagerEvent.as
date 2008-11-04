package com.layerglue.flex3.base.events
{
	import flash.events.Event;

	public class PreloaderManagerEvent extends Event
	{
		public static const APPLICATION_LOAD_COMPLETE:String = "applicationLoadComplete";
		public static const APPLICATION_INIT_COMPLETE:String = "applicationInitComplete";
		public static const INITIAL_ASSETS_LOAD_COMPLETE:String = "initAssetsLoadComplete";
		
		public function PreloaderManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}