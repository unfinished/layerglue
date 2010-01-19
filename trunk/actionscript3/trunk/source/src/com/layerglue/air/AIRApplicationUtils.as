package com.layerglue.air
{
	import flash.desktop.NativeApplication;

	public class AIRApplicationUtils
	{
		/**
		 * Returns whether or not the application is running in debug mode based on whether
		 * a call to retrieve the startAtLogin throws an error.
		 */
		public static function get runningInDebugMode():Boolean
		{
			var sal:Boolean;
			
			try
			{
				sal = NativeApplication.nativeApplication.startAtLogin;
			}
			catch(error:Error)
			{
				return true;
			}
			
			return false;
		}
		
		/**
		 * Returns the value of NativeApplication.nativeApplication.startAtLogin if we not in debug
		 * mode, otherwise the value defaults to false to avoid errors.
		 */
		public static function get startAtLogin():Boolean
		{
			if(!runningInDebugMode)
			{
				return NativeApplication.nativeApplication.startAtLogin;
			}
			
			return false;
		}
		
		/**
		 * Sets the value of NativeApplication.nativeApplication.startAtLogin but checks to see if
		 * we are in debug mode to avoid errors
		 */
		public static function set startAtLogin(value:Boolean):void
		{
			if(!runningInDebugMode)
			{
				NativeApplication.nativeApplication.startAtLogin = value; 
			}
		}
	}
}