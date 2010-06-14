package com.layerglue.flash.events 
{
	import flash.events.Event;

	/**
	 * @author jamiecopeland
	 */
	public class FlashPreloadManagerEvent extends Event 
	{
		public static const PRELOADER_VIEW_ANIMATION_COMPLETE:String = "preloaderAnimationComplete";
		
		public function FlashPreloadManagerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
		}
	}
}
