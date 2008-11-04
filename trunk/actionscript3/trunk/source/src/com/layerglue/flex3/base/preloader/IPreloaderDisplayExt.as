package com.layerglue.flex3.base.preloader
{
	import mx.preloaders.IPreloaderDisplay;
	
	public interface IPreloaderDisplayExt extends IPreloaderDisplay
	{
		function startTransitionOut():void;
		function triggerComplete():void;
	}
}