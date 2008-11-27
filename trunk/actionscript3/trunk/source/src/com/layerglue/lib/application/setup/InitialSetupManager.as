package com.layerglue.lib.application.setup
{
	import com.layerglue.flex3.base.collections.FlexCollection;
	import com.layerglue.flex3.base.collections.strategies.FlexCollectionStrategyMap;
	import com.layerglue.lib.application.LayerGlueLocator;
	import com.layerglue.lib.application.controllers.ControllerHierarchyCreator;
	import com.layerglue.lib.application.controllers.INavigableController;
	import com.layerglue.lib.application.maps.ControllerToViewMap;
	import com.layerglue.lib.application.maps.StructuralDataToContollerMap;
	import com.layerglue.lib.application.navigation.NavigationManager;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.base.collections.ArrayExt;
	import com.layerglue.lib.base.collections.Collection;
	import com.layerglue.lib.base.collections.strategies.CollectionStrategy;
	import com.layerglue.lib.base.io.xml.XMLDeserializationMap;
	import com.layerglue.lib.base.io.xml.XMLDeserializer;
	
	import flash.events.EventDispatcher;
	
	// TODO: Not sure this needs an interface - it's never used in a capacity that requires one
	public class InitialSetupManager extends EventDispatcher implements IInitialSetupManager
	{
		public function InitialSetupManager()
		{
			super();
		}
		
		protected var _xmlToStructuralDataMap:XMLDeserializationMap
		/**
		 * 
		 */
		public function get xmlToStructuralDataMap():XMLDeserializationMap
		{
			return _xmlToStructuralDataMap;
		}
		
		public function set xmlToStructuralDataMap(value:XMLDeserializationMap):void
		{
			_xmlToStructuralDataMap = value;
		}
		
		protected var _structuralDataToControllerMap:StructuralDataToContollerMap;
		/**
		 * 
		 */
		public function get structuralDataToControllerMap():StructuralDataToContollerMap
		{
			return _structuralDataToControllerMap;
		}
		
		public function set structuralDataToControllerMap(value:StructuralDataToContollerMap):void
		{
			_structuralDataToControllerMap = value;
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
			var lgl:LayerGlueLocator = LayerGlueLocator.getInstance();
			lgl.structuralData = createStructuralData(structuralDataXML);
			lgl.controller = createControllerHierarchy(lgl.structuralData);
			lgl.navigationManager = new NavigationManager(lgl.controller);
		}
		
		protected function createStructuralData(xml:XML):IStructuralData
		{
			var collectionStrategyMap:FlexCollectionStrategyMap = new FlexCollectionStrategyMap();
			collectionStrategyMap.addMapping(FlexCollection, new CollectionStrategy());
			collectionStrategyMap.addMapping(Collection, new CollectionStrategy());
			// TODO: do we need ArrayExt?
			collectionStrategyMap.addMapping(ArrayExt, new CollectionStrategy());
			
			var d:XMLDeserializer = new XMLDeserializer();
			d.map = xmlToStructuralDataMap;
			d.collectionStrategyMap = collectionStrategyMap;
			
			return d.deserialize(xml);
		}
		
		protected function createControllerHierarchy(structuralData:IStructuralData):INavigableController
		{
			var chc:ControllerHierarchyCreator = new ControllerHierarchyCreator();
			chc.structureToControllerMap = structuralDataToControllerMap;
			chc.controllerToViewMap = controllerToViewMap;
			var c:INavigableController = chc.createHierarchy(structuralData) as INavigableController;
			
			return c;
		}
		
	}
}