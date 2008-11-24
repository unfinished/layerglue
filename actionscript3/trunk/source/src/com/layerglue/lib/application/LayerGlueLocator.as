package com.layerglue.lib.application
{
	import com.layerglue.lib.application.controllers.IController;
	import com.layerglue.lib.application.navigation.NavigationManager;
	import com.layerglue.lib.application.structure.IStructuralData;
	
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class LayerGlueLocator extends EventDispatcher
	{
		public function LayerGlueLocator()
		{
			super();
		}
		
		private static var _instance:LayerGlueLocator;
		
		public static function getInstance():LayerGlueLocator
		{
			if (!_instance)
			{
				_instance = new LayerGlueLocator();
			}
			return _instance;
		}
		
		private var _structuralData:IStructuralData;
		/**
		 * 
		 */
		public function get structuralData():IStructuralData
		{
			return _structuralData;
		}
		
		public function set structuralData(value:IStructuralData):void
		{
			_structuralData = value;
		}
		
		private var _controller:IController;
		/**
		 * 
		 */
		public function get controller():IController
		{
			return _controller;
		}
		
		public function set controller(value:IController):void
		{
			_controller = value;
		}
		
		protected var _navigationManager:NavigationManager
		/**
		 * 
		 */
		public function get navigationManager():NavigationManager
		{
			return _navigationManager;
		}
		
		public function set navigationManager(value:NavigationManager):void
		{
			_navigationManager = value;
		}
		
	}
}