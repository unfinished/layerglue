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
		function get rootLoadProportion():Number;
		function get preloaderDisplay():DisplayObject;
		
		function addMainInstanceToDisplayList(mainInstance:IPreloadableFlashApplication):void;
		
		
		//function get minDisplayTime():Number;
		//function get isComplete():Boolean;
	}
}