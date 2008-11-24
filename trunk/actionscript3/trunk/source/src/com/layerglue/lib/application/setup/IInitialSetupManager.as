package com.layerglue.lib.application.setup
{
	import com.layerglue.lib.application.maps.ControllerToViewMap;
	import com.layerglue.lib.application.maps.StructuralDataToContollerMap;
	import com.layerglue.lib.base.io.xml.XMLDeserializationMap;
	
	import flash.events.IEventDispatcher;
	
	public interface IInitialSetupManager extends IEventDispatcher
	{
		function get xmlToStructureMap():XMLDeserializationMap;
		function set xmlToStructureMap(value:XMLDeserializationMap):void;
		
		function get structureToControllerMap():StructuralDataToContollerMap;
		function set structureToControllerMap(value:StructuralDataToContollerMap):void;
		
		function get controllerToViewMap():ControllerToViewMap;
		function set controllerToViewMap(value:ControllerToViewMap):void;
				
		function setup(structuralDataXML:XML):void; 
	}
}