package com.layerglue.flex3.base.events
{
	import flash.events.Event;

	public class PreloadManagerEvent extends Event
	{
		public static const INITIAL_ASSETS_LOAD_COMPLETE:String = "initialAssetsLoadComplete";
		public static const ROOT_LOAD_COMPLETE:String = "rootLoadComplete";
		
		public function PreloadManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}