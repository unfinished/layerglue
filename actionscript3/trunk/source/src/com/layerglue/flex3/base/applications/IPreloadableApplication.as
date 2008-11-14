package com.layerglue.flex3.base.applications
{
	public interface IPreloadableApplication
	{
		/**
		 * A reference to the class that should be instantiated as the load manager for the
		 * application, defaulting to LoadManager.
		 * 
		 * <p>NOTE: This is a reference to the class not an instance of the class itself.</p>
		 */
		function get loadManager():Class;
		function set loadManager(value:Class):void;
		
		/**
		 * The minimum amount of time the preloader should be shown for, defaulting to 0.
		 */
		function get preloaderMinDisplayTime():Number
		function set preloaderMinDisplayTime(value:Number):void
	}
}