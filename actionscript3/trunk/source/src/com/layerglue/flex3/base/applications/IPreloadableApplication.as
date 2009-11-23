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
		
		/**
		 * An arbitrary value representing the total number of units to be loaded, defaulting to 1.
		 * 
		 */
		function get loadManagerTotalValue():Number;
		function set loadManagerTotalValue(value:Number):void;
		
		/**
		 * The proportion of loadManagerTotalValue which is taken up by the main swf.
		 */
		function get loadManagerMainSWFProportion():Number;
		function set loadManagerMainSWFProportion(value:Number):void;
	}
}