package com.layerglue.flex3.base.preloader
{
	import mx.preloaders.IPreloaderDisplay;
	import mx.preloaders.Preloader;
	
	public interface IPreloaderDisplayExt extends IPreloaderDisplay
	{
		/**
		 * Removes any listeners and if the instance has a parent, removes itself from the parent's
		 * displayList.
		 */
		function destroy():void;
		
		/**
		 * The minimun amount of time in milliseconds that the preloder should appear for.
		 */
		function get minDisplayTime():Number;
		function set minDisplayTime(value:Number):void;
		
		/**
		 * A reference
		 */
		function get flexPreloader():Preloader;
	}
}