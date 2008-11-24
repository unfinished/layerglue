package com.layerglue.lib.application.setup
{
	import com.layerglue.lib.application.maps.ControllerToViewMap;
	import com.layerglue.lib.application.maps.StructuralDataToContollerMap;
	import com.layerglue.lib.base.io.xml.XMLDeserializationMap;
	
	import flash.events.IEventDispatcher;
	
	public interface IInitialSetupManager extends IEventDispatcher
	{
		function get xmlToStructuralDataMap():XMLDeserializationMap;
		function set xmlToStructuralDataMap(value:XMLDeserializationMap):void;
		
		function get structuralDataToControllerMap():StructuralDataToContollerMap;
		function set structuralDataToControllerMap(value:StructuralDataToContollerMap):void;
		
		function get controllerToViewMap():ControllerToViewMap;
		function set controllerToViewMap(value:ControllerToViewMap):void;
				
		function setup(structuralDataXML:XML):void; 
	}
}