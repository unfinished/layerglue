package com.layerglue.flex3.preloader
{
	import com.layerglue.lib.base.io.FlashVars;
	
	import flash.events.Event;
	
	import mx.preloaders.DownloadProgressBar;
	
	/**
	 * CustomPreloader is a very basic override of the standard Flex DownloadProgressBar that adds
	 * in access to FlashVars from 
	 */
	public class CustomPreloader extends DownloadProgressBar
	{
		public function CustomPreloader()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			FlashVars.initialize(root);
			start();
		}
		
		protected function start():void
		{
			//Override in subclasses - from this point on FlashVars are available
		}
		
	}
}