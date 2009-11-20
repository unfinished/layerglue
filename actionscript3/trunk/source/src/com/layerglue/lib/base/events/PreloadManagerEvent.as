package com.layerglue.lib.base.events
{
	import flash.events.Event;

	public class PreloadManagerEvent extends Event
	{
		public static const ROOT_LOAD_COMPLETE:String = "rootLoadComplete";
		
		//TODO this needs to be removed once its use within the flex preloader is removed
		public static const INITIAL_ASSETS_LOAD_COMPLETE:String = "initialAssetsLoadComplete";
		
		public function PreloadManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}