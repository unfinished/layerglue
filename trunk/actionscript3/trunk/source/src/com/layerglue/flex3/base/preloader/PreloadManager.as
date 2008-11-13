package com.layerglue.flex3.base.preloader
{
	import com.layerglue.lib.base.io.LoadManager;
	
	import flash.events.EventDispatcher;
	
	import mx.preloaders.IPreloaderDisplay;
	import mx.preloaders.Preloader;
	
	/**
	 * A proxy to sit between the preloader and the main application
	 */
	public class PreloadManager extends EventDispatcher
	{
		private var _loadManager:LoadManager;
		
		public function PreloadManager(preloaderDisplay:IPreloaderDisplay, loadManager:LoadManager)
		{
			super();
			
			_preloaderDisplay = preloaderDisplay;
			
			_loadManager = loadManager;
			
			//Dont really need to do this, but some objects may be listening for a start event, so
			//method is called here to ensure start event is dispatched.
			_loadManager.start();
		}
		 
		private static var _instance:PreloadManager;
		
		public static function initialize(preloaderDisplay:IPreloaderDisplay, loadManager:LoadManager):PreloadManager
		{
			if(!_instance)
			{
				_instance = new PreloadManager(preloaderDisplay, loadManager);
			}
			
			return _instance;
		}
		
		public static function getInstance():PreloadManager
		{
			return _instance;
		}
		
		private var _preloaderDisplay:IPreloaderDisplay;
		
		public function get preloaderDisplay():IPreloaderDisplay
		{
			return _preloaderDisplay;
		}
		
		private var _flexPreloader:Preloader;
		
		public function get flexPreloader():Preloader
		{
			return _flexPreloader;
		}
		
		public function set flexPreloader(value:Preloader):void
		{
			_flexPreloader = value;
		}
		
		public function get initialLoadManager():LoadManager
		{
			return _loadManager;
		}
	}
}