package com.layerglue.flex3.base.preloader
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * A proxy to sit between the preloader and the main application
	 */
	public class PreloaderCommunicator extends EventDispatcher
	{
		public function PreloaderCommunicator(preloader:IPreloaderDisplayExt)
		{
			super();
			
			_preloader = preloader;
		}
		
		private static var _instance:PreloaderCommunicator;
		
		public static function initialize(preloader:IPreloaderDisplayExt):PreloaderCommunicator
		{
			if(!_instance)
			{
				_instance = new PreloaderCommunicator(preloader);
			}
			
			return _instance;
		}
		
		public static function getInstance():PreloaderCommunicator
		{
			return _instance;
		}
		
		private var _preloader:IPreloaderDisplayExt;
		
		public function get preloader():IPreloaderDisplayExt
		{
			return _preloader;
		}
	}
}