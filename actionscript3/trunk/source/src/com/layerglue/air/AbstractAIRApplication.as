package com.layerglue.air
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindowInitOptions;
	import flash.system.Capabilities;
	
	/**
	 * Abstract base-class for a pure Actionscript AIR application. You should sub-class this and
	 * set it as the default compiled class for the project. It will be automatically added to the
	 * stage of the initial NativeWindow instance. In this way it acts much like the standard
	 * Flash Document class.
	 * 
	 * NOTE: You must set the initialWindow.visible property inside the Application Descriptor
	 * to true, otherwise the window won't be visible when the application opens.
	 * 
	 * @author LayerGlue
	 */
	public class AbstractAIRApplication extends AbstractAIRWindow
	{
		/**
		 * You should sub-class AbstractAIRApplication and set it as your default compiled
		 * application file.
		 * 
		 * @param initOptions The options for the new Application window. Usually these are
		 * set in the descriptor XML, and if so are ignored here. It is only ever useful to pass
		 * through options if you plan to create an additional AIR application window, for example
		 * when using the bootstrapper.
		 */
		public function AbstractAIRApplication(initOptions:NativeWindowInitOptions = null)
		{
			traceVersionInfo();
			
			// initOptions will be ignored if this instance is the default compiled class
			super(initOptions);
		}
		
		/**
		 * Shortcut for retrieving the NativeApplication instance.
		 */
		public function get nativeApplication():NativeApplication
		{
			return NativeApplication.nativeApplication;
		}
		
		protected var _applicationIcons:AIRApplicationIcons;
		/**
		 * Access to an instance of the AIRApplicationIcon class. This allows you to change the
		 * system tray icon and dock icon, and the context menus for both.
		 * 
		 * @see AIRApplicationIcon
		 */
		public function get applicationIcons():AIRApplicationIcons
		{
			if (!_applicationIcons)
			{
				_applicationIcons = new AIRApplicationIcons;
			}
			return _applicationIcons;
		}
		
		/**
		 * @private
		 * Traces versioning information for the AIR Application. Values are extracted from the
		 * AIR descriptor XML and the system capabilities class.
		 */
		protected function traceVersionInfo():void
		{
			var appDescriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appDescriptor.namespace();
			var appId:String = appDescriptor.ns::id;
			var appCopyright:String = appDescriptor.ns::copyright;
			var appVersion:String = appDescriptor.ns::version;
			
			trace("========================================================");
			trace(" LayerGlue AIR App - " + " AppID: '" + appId + "' " + appVersion );
			trace(" (AIR Runtime version: " + NativeApplication.nativeApplication.runtimeVersion
				+  " - Display: " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + ")");
			trace("========================================================");
		}
		
	}
}
