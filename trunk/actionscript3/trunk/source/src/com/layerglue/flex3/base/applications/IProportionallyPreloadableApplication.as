package com.layerglue.flex3.base.applications
{
	/**
	 * Defines the methods and properties required to act as a preloader capable of proportional
	 */
	public interface IProportionallyPreloadableApplication extends IPreloadableApplication
	{
		/**
		 * An arbitrary value representing the total number of units to be loaded, defaulting to 1.
		 * 
		 */
		function get loadManagerTotalValue():Number;
		function set loadManagerTotalValue(value:Number):void;
		
		/**
		 * The proportion of loadManagerTotalValue which is taken up by the main swf, defaulting to 0.6.
		 */
		function get loadManagerMainSWFValue():Number;
		function set loadManagerMainSWFValue(value:Number):void;
	}
}