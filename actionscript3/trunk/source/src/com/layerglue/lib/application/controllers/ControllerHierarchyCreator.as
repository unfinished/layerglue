package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.maps.ControllerToViewMap;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.base.collections.HashMap;
	import com.layerglue.lib.base.utils.ReflectionUtils;
	import com.wildside.maps.WildSideControllerToViewMap;
	
	public class ControllerHierarchyCreator
	{
		public var defaultController:Class;
		
		public var structureToControllerMap:HashMap;
		public var controllerToViewMap:ControllerToViewMap;
		
		public function ControllerHierarchyCreator()
		{
			
		}
		
		public function createHierarchy(structuralData:IStructuralData, controller:IController=null):IController
		{
			if (!structureToControllerMap)
			{
				throw new Error("Attempted controller hierarchy creation with no map specified.");
			}
			
			var controller:IController;
			if (controller == null)
			{
				controller = createControllerInstance(structuralData);
			}
			
			var structuralDataNode:IStructuralData;
			for each(structuralDataNode in structuralData.children)
			{
				var childController:IController = createControllerInstance(structuralDataNode, controller);
				controller.children.push(childController);
				createHierarchy(structuralDataNode, childController);
			}
			
			return controller;
			
			// throw error if no default class is specified
		}
		
		protected function createControllerInstance(structuralData:IStructuralData, parent:IController=null):IController
		{
			var structuralClassRef:Class = ReflectionUtils.getClassReference(structuralData);
			var controllerClassRef:Class = structureToControllerMap.get(structuralClassRef);
			
			var controller:IController = new controllerClassRef();
			controller.parent = parent;
			controller.structuralData = structuralData;
			
			//TODO: remove line below later
			controller.controllerToViewClassMap = new WildSideControllerToViewMap();
			
			return controller;
		}
		
	}
}