package com.layerglue.flash.preloader
{
	import com.layerglue.lib.base.loaders.RootLoaderProxy;
	
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	public interface IRootPreloader extends IEventDispatcher
	{
		function get mainClassName():String;
		function get rootLoaderProxy():RootLoaderProxy;
		function get rootLoadProportion():Number;
		function get minDisplayTime():Number;
		function get preloaderDisplay():DisplayObject;
		
		function showMainApp():void;
	}
}