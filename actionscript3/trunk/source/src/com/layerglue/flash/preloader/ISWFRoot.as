package com.layerglue.flash.preloader
{
	import com.layerglue.lib.base.loaders.RootLoaderProxy;

	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	import com.layerglue.flash.applications.IPreloadableFlashApplication;

	public interface ISWFRoot extends IEventDispatcher
	{
		function get mainClassName():String;
		function get rootLoaderProxy():RootLoaderProxy;
		function get rootLoadProportion():int;
		function get totalLoadValue():int;
		function get preloaderView():DisplayObject;
		
		function addMainInstanceToDisplayList(mainInstance:IPreloadableFlashApplication):void;
	}
}