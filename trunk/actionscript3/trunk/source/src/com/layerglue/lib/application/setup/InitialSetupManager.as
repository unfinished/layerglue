package com.layerglue.lib.application.setup
{
	import com.layerglue.lib.application.maps.ControllerToViewMap;
	import com.layerglue.lib.application.maps.StructuralDataToContollerMap;
	import com.layerglue.lib.base.io.xml.XMLDeserializationMap;
	
	import flash.events.EventDispatcher;
	
	public class InitialSetupManager extends EventDispatcher implements IInitialSetupManager
	{
		public function InitialSetupManager()
		{
			super();
		}
		
		protected var _xmlToStructureMap:XMLDeserializationMap
		/**
		 * 
		 */
		public function get xmlToStructureMap():XMLDeserializationMap
		{
			return _xmlToStructureMap;
		}
		
		public function set xmlToStructureMap(value:XMLDeserializationMap):void
		{
			_xmlToStructureMap = value;
		}
		
		protected var _structureToControllerMap:StructuralDataToContollerMap;
		/**
		 * 
		 */
		public function get structureToControllerMap():StructuralDataToContollerMap
		{
			return _structureToControllerMap;
		}
		
		public function set structureToControllerMap(value:StructuralDataToContollerMap):void
		{
			_structureToControllerMap = value;
		}
		
		protected var _controllerToViewMap:ControllerToViewMap;
		/**
		 * 
		 */
		public function get controllerToViewMap():ControllerToViewMap
		{
			return _controllerToViewMap;
		}
		
		public function set controllerToViewMap(value:ControllerToViewMap):void
		{
			_controllerToViewMap = value;
		}
		
		public function setup(structuralDataXML:XML):void
		{
			
		}
		
	}
}