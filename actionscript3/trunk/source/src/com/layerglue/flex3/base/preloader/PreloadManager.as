package com.layerglue.flex3.base.preloader
{
	import com.layerglue.flex3.base.events.PreloadManagerEvent;
	import com.layerglue.lib.base.events.EventListenerCollection;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	import com.layerglue.lib.base.loaders.RootLoaderProxy;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	
	import mx.events.FlexEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.preloaders.IPreloaderDisplay;
	import mx.preloaders.Preloader;
	
	
	/**
	 * Dispatched when all assets added to the loadManager are loaded
	 */
	[Event(name="initialAssetsLoadComplete", type="com.layerglue.flex3.base.events.PreloadManagerEvent")]
	
	/**
	 * Dispatched when the entire load process, including minimumDisplayTime of IPreloaderDisplay is
	 * complete.
	 */
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * A proxy to sit between the preloader and the main application
	 * 
	 * <p></p>
	 */
	public class PreloadManager extends EventDispatcher
	{
		/**
		 * The default time in milliseconds to show the preloader display if a value is not set in
		 * the main application
		 */
		public static var DEFAULT_PRELOADER_MIN_DISPLAY_TIME:Number = 0;
		
		/**
		 * The default class to be used to manage and measure loading initial site assets if  a
		 * value is not set in the main application
		 */
		public static var DEFAULT_LOAD_MANAGER:Class = ProportionalLoadManager;
		
		/**
		 * The default arbitrary total value used by the loadManager if a value is not set in the
		 * main application
		 */
		public static var DEFAULT_LOAD_MANAGER_TOTAL_VALUE:Number = 1;
		
		/**
		 * The default proportion of the main swf as a segment the overall filesize being loaded
		 * before the site is initialized. 
		 */
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
		
		private var _listenerCollection:EventListenerCollection;
		
		public function PreloadManager(preloaderDisplay:IPreloaderDisplay)
		{
			super();
			
			_preloaderDisplay = preloaderDisplay;
			
			_listenerCollection = new EventListenerCollection();
			
			
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
			
			_listenerCollection.createListener(_loadManager, Event.COMPLETE, loadManagerCompleteHandler);
			
			//This method doesnt start the load process as the main swf is already loading, but it
			//firest the load start event, which some objects will be listening for.
			_loadManager.start();
		}
		
		/**
		 * Hooked up to the complete event of the loadManager, and dispatching a custom
		 * PreloadManagerEvent signifying that all user defined assets have finished loading.
		 */
		protected function loadManagerCompleteHandler(event:Event):void
		{
			dispatchEvent(new PreloadManagerEvent(PreloadManagerEvent.INITIAL_ASSETS_LOAD_COMPLETE));
		}
		
		/**
		 * Hooked up to the FlexEvent.PRELOADER_DONE of the Flex system Preloader, and dispatching a
		 * complete event, signifying that all preloading and initilization is complete.
		 */
		protected function flexPreloaderDoneHandler(event:FlexEvent):void
		{
			dispatchEvent(new Event(Event.COMPLETE));
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
			
			_listenerCollection.createListener(flexPreloader, FlexEvent.PRELOADER_DONE, flexPreloaderDoneHandler);
		}
		
		private var _loadManager:ProportionalLoadManager;
		
		/**
		 * The ProportionalLoadManager responsible for the managing and measuring the initial assets
		 * to be loaded in to the site.
		 * 
		 * <p></p>
		 */
		public function get loadManager():ProportionalLoadManager
		{
			return _loadManager;
		}
		
		public function destroy():void
		{
			if(_listenerCollection)
			{
				_listenerCollection.destroy();
			}
		}
	}
}