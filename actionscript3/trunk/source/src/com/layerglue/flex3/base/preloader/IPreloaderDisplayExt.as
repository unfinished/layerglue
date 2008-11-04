package com.layerglue.flex3.base.preloader
{
	import mx.preloaders.IPreloaderDisplay;
	
	public interface IPreloaderDisplayExt extends IPreloaderDisplay
	{
		function startTransitionOut():void;
		function triggerComplete():void;
		
		/*
		function get applicationSWFLoadProportion():Number;
		function set applicationSWFLoadProportion(value:Number):void;
		*/
	}
}