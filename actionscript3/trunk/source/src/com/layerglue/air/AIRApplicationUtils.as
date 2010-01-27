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
		
		/**
		 * Returns a value from the app descriptor XML by the specified key. Returns an empty string
		 * if the key was not found. Note, the value must be a simple XML node with no children,
		 * for example the 'version' and 'name' nodes. Since the app descriptor XML allows custom
		 * nodes to be added this is a good way of including custom properties into an AIR build.
		 */
		public static function getAppDescriptorValue(key:String):String
		{
			var desc:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = desc.namespace();
			var q:QName = new QName(ns, key);
			var value:String = desc.child(q);
			return value;
		}
		
		/**
		 * Returns the version number as defined in the application descriptor XML.
		 */
		public static function get applicationVersion():String
		{
			return getAppDescriptorValue("version");
		}
	}
}