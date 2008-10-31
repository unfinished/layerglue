package com.layerglue.lib.base.loaders
{
	import flash.net.URLRequest;
	
	/**
	 * Defines the methods needed to implement the loading of a single download.
	 */
	public interface ISingleLoader extends ILoader
	{
		/**
		 * Starts the loading or a URLRequest.
		 * 
		 * @request The url from which to start loading.
		 */
		function load(request:URLRequest):void;
		
		/**
		 * The number of bytes currently loaded.
		 */
		function getBytesLoaded():uint;
		
		/**
		 * The total number of bytes to be loaded
		 */
		function getBytesTotal():uint;
		
		/**
		 * The percentage of the download that has been completed.
		 */
		function getPercentLoaded():Number;
		
		/**
		 * The data received from the load operation. This property is populated only when the load
		 * operation is complete.
		 */
		function getData():*;
		
		//TODO Look into adding getDataFormat method 
		//function getDataFormat():String;
		
		
		
		//NOTE: Use the convention below for typed data in concrete implementations
		
		//function getTypedData():XML
		//function getTypedData():BitmapData
	}
}