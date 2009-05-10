package com.layerglue.air
{
	import flash.desktop.NativeApplication;
	
	/**
	 * The AbstractAIRBootstrapper is used to open a new application window and replace
	 * the original one specified in the app descriptor XML. The original window is closed and
	 * removed and the new window becomes the base of the AIR app. This is primarily used to
	 * create invisible apps using the window type UTILITY or LIGHTWEIGHT.
	 * 
	 * You should override this class and then set it as the default compiled class.
	 * The original window will be closed and destroyed, and the new window you specify in
	 * getNativeWindowInstance() will be opened instead.
	 * 
	 * NOTE: You must set the initialWindow.visible property in the app descriptor XML to false,
	 * otherwise the original window will show for a split-second before closing.
	 * 
	 * @author LayerGlue
	 */
	public class AbstractAIRBootstrapper extends AbstractAIRWindow
	{
		/**
		 * You should sub-class AbstractAIRBootstrapper and set it as your default compiled class.
		 */
		public function AbstractAIRBootstrapper()
		{
			super();
			
			// Close the initial window created by the AIR runtime. With autoExit set
			// to false the app will still be running but will in effect be invisible.
			NativeApplication.nativeApplication.autoExit = false;
			nativeWindow.close();
			_nativeWindow = null;
			stage.removeChild(this);
			
			// Open the new application window
			var newApplcationWindow:AbstractAIRApplication = getNewApplcationInstace();
			newApplcationWindow.open();
		}
		
		/**
		 * You must override this method and return an instance of the new window that will act
		 * as the application base. The original window represented by this bootstrapper
		 * class will be closed and the new one will be opened automatically. Remember to set
		 * the NativeWindowInitOptions and any transparency/system-chrome you may require.
		 */
		protected function getNewApplcationInstace():AbstractAIRApplication
		{
			throw new Error("New application instance not specified for bootstrapper");
		}
	}
}