package com.layerglue.flash.applications
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;

	public interface IPreloadableFlashApplication extends IEventDispatcher
	{
		function startInitialLoad():void;
		function show(preloaderView:DisplayObject):void;
	}
}