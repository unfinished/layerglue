package com.layerglue.flex3.base.preloader
{
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	import com.layerglue.lib.base.loaders.RootLoaderProxy;
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.preloaders.IPreloaderDisplay;
	import mx.preloaders.Preloader;
	
	/**
	 * A proxy to sit between the preloader and the main application
	 */
	public class PreloadManager extends EventDispatcher
	{
		public static var DEFAULT_PRELOADER_MIN_DISPLAY_TIME:Number = 0;
		public static var DEFAULT_LOAD_MANAGER:Class = ProportionalLoadManager;
		public static var DEFAULT_LOAD_MANAGER_TOTAL_VALUE:Number = 1;
		public static var DEFAULT_LOAD_MANAGER_MAIN_SWF_VALUE:Number = 0.6;
		
		public static function getLoadManagerClassReference(systemManager:ISystemManager):Class
		{
			return (systemManager.info()["loadManager"] ? getDefinitionByName( systemManager.info()["loadManager"] ) : DEFAULT_LOAD_MANAGER) as Class;
		}
		
		public static function getPreloaderMinDisplayTime(systemManager:ISystemManager):Number
		{
			return systemManager.info()["preloaderMinDisplayTime"] ? systemManager.info()["preloaderMinDisplayTime"] : DEFAULT_PRELOADER_MIN_DISPLAY_TIME;
		}
		
		public static function getLoadManagerTotalValue(systemManager:ISystemManager):Number
		{
			return systemManager.info()["loadManagerTotalValue"] ? systemManager.info()["loadManagerTotalValue"] : DEFAULT_LOAD_MANAGER_TOTAL_VALUE;
		}
		
		public static function getLoadManagerMainSWFValue(systemManager:ISystemManager):Number
		{
			return systemManager.info()["loadManagerMainSWFValue"] ? systemManager.info()["loadManagerMainSWFValue"] : DEFAULT_LOAD_MANAGER_MAIN_SWF_VALUE;
		}
		
		public function PreloadManager(preloaderDisplay:IPreloaderDisplay)
		{
			super();
			
			_preloaderDisplay = preloaderDisplay;
			
			//Set up the load manager
			var systemManager:ISystemManager = (preloaderDisplay as DisplayObject).root as ISystemManager;
			var loadManagerClassRef:Class = getLoadManagerClassReference(systemManager);
			_loadManager = new loadManagerClassRef();
			_loadManager.totalValue = getLoadManagerTotalValue(systemManager);
			
			//Create the RootLoaderProxy and add it to the load manager				
			var item:LoadManagerToken = new LoadManagerToken(
							new RootLoaderProxy((preloaderDisplay as DisplayObject).root.loaderInfo),
							null,
							null,
							getLoadManagerMainSWFValue((preloaderDisplay as DisplayObject).root as SystemManager));
			
			_loadManager.addItem(item);
			
			//This method doesnt start the load process as the main swf is already loading, but it
			//firest the load start event, which some objects will be listening for.
			_loadManager.start();
		}
		 
		private static var _instance:PreloadManager;
		
		public static function initialize(preloaderDisplay:IPreloaderDisplay):PreloadManager
		{
			if(!_instance)
			{
				_instance = new PreloadManager(preloaderDisplay);
			}
			
			return _instance;
		}
		
		public static function getInstance():PreloadManager
		{
			return _instance;
		}
		
		private var _preloaderDisplay:IPreloaderDisplay;
		
		/**
		 * The IPreloaderDisplay instance being used by to show load progress.
		 */
		public function get preloaderDisplay():IPreloaderDisplay
		{
			return _preloaderDisplay;
		}
		
		private var _flexPreloader:Preloader;
		
		/**
		 * The Preloader instance created by the Flex SystemManager.
		 */
		public function get flexPreloader():Preloader
		{
			return _flexPreloader;
		}
		
		public function set flexPreloader(value:Preloader):void
		{
			_flexPreloader = value;
		}
		
		private var _loadManager:ProportionalLoadManager;
		
		public function get loadManager():ProportionalLoadManager
		{
			return _loadManager;
		}
	}
}