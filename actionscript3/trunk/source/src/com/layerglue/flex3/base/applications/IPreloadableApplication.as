package com.layerglue.flex3.base.applications
{
	/**
	 * 
	 */
	public interface IPreloadableApplication
	{
		/**
		 * The minimum amount of time the preloader should be shown for, defaulting to 0.
		 */
		function get preloaderMinDisplayTime():Number
		function set preloaderMinDisplayTime(value:Number):void
	}
}