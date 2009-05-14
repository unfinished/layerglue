package com.layerglue.air
{
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.NativeMenu;
	
	/**
	 * Allows you to change the application icons, for example the system tray icon in Windows,
	 * or the dock icon in OSX. It also allows you to change the context menus associated with
	 * both icons.
	 * 
	 * An instance of this class can be created anywhere, as changing icon assets and menus only
	 * requires static methods on NativeApplication. For ease-of-use an instance of this class
	 * is made available on AbstractAIRApplication.
	 * 
	 * If you need to change icons and menus regularly at runtime then a good solution is to
	 * sub-class this and add in alternate states/methods ontop.
	 * 
	 * @author LayerGlue
	 */
	public class AIRApplicationIcons
	{
		public function AIRApplicationIcons()
		{
			
		}
		
		/**
		 * Shortcut for retrieving the NativeApplication instance.
		 */
		public function get nativeApplication():NativeApplication
		{
			return NativeApplication.nativeApplication;
		}
		
		/**
		 * The system tray icon, supported by Windows and Linux. It requires an array of BitmapData
		 * instances and will choose the one that's closest to the size of the displayed icon.
		 * This property will have no effect on a non-Windows/Linux OS.
		 */
		public function get systemTrayIcon():Array
		{
			var a:Array = NativeApplication.supportsSystemTrayIcon ? (nativeApplication.icon as SystemTrayIcon).bitmaps : null;
			return a;
		}
		
		public function set systemTrayIcon(bitmaps:Array):void
		{
			if (NativeApplication.supportsSystemTrayIcon)
			{
				(nativeApplication.icon as SystemTrayIcon).bitmaps = bitmaps;
			}
		}
		
		/**
		 * The dock icon, supported by Mac OSX. It requires an array of BitmapData
		 * instances and will choose the one that's closest to the size of the displayed icon.
		 * This property will have no effect on a non-OSX OS.
		 */
		public function get dockIcon():Array
		{
			var a:Array = NativeApplication.supportsDockIcon ? (nativeApplication.icon as DockIcon).bitmaps : null;
			return a;
		}
		
		public function set dockIcon(bitmaps:Array):void
		{
			if (NativeApplication.supportsDockIcon)
			{
				(nativeApplication.icon as DockIcon).bitmaps = bitmaps;
			}
		}
		
		/**
		 * The system tray menu, accessible by right-clicking on the system tray icon.
		 * This property will have no effect on non-Windows/Linux OS.
		 */
		public function get systemTrayIconMenu():NativeMenu
		{
			var m:NativeMenu = NativeApplication.supportsSystemTrayIcon ? (nativeApplication.icon as SystemTrayIcon).menu : null;
			return m;
		}
		
		public function set systemTrayIconMenu(menu:NativeMenu):void
		{
			if (NativeApplication.supportsSystemTrayIcon)
			{
				(nativeApplication.icon as SystemTrayIcon).menu = menu;
			}
		}
		
		/**
		 * The dock icon menu, accessible by right-clicking on the system tray icon.
		 * This property will have no effect on non-OSX OS.
		 */
		public function get dockIconMenu():NativeMenu
		{
			var m:NativeMenu = NativeApplication.supportsDockIcon ? (nativeApplication.icon as DockIcon).menu : null;
			return m;
		}
		
		public function set dockIconMenu(menu:NativeMenu):void
		{
			if (NativeApplication.supportsDockIcon)
			{
				(nativeApplication.icon as DockIcon).menu = menu;
			}
		}
	}
}