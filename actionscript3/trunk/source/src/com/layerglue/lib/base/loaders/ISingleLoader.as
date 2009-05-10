package com.layerglue.lib.base.loaders
{
	import flash.net.URLRequest;

	/**
	 * Defines the methods needed to implement the loading of a single download.
	 */
	public interface ISingleLoader extends IMeasurableLoader
	{
		/**
		 * Starts the loading or a URLRequest.
		 * 
		 * @request The url from which to start loading.
		 */
		function load(request:URLRequest):void;
		
		/**
		 * The data received from the load operation. This property is populated only when the load
		 * operation is complete.
		 */
		function getData():*;
		
		//TODO Look into adding getDataFormat method 
		//function getDataFormat():String;
		
		// -----------------------------------------------------------------------------------------
		//NOTE: Use the convention below for typed data in concrete implementations
		
		//function getTypedData():XML
		//function getTypedData():BitmapData
	}
}