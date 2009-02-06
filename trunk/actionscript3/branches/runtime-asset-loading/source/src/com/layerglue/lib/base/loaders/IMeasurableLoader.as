package com.layerglue.lib.base.loaders
{
	/**
	 * NOTE: Since variables cannot be defined in AS3 interfaces, bytesLoaded and bytesTotal have
	 * been replaced with explicit getter methods here so they can be included in the interface.
	 */
	public interface IMeasurableLoader extends ILoader
	{
		/**
		 * The number of bytes currently loaded.
		 */
		function getBytesLoaded():uint;
		
		/**
		 * The total number of bytes to be loaded
		 */
		function getBytesTotal():uint;
	}
}