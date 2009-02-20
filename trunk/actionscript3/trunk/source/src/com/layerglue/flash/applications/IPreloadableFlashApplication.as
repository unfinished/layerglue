package com.layerglue.flash.applications
{
	import flash.events.IEventDispatcher;

	public interface IPreloadableFlashApplication extends IEventDispatcher
	{
		function startInitialLoad():void;
	}
}