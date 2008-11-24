package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.maps.ControllerToViewMap;
	import com.layerglue.lib.application.maps.StructureToContollerMap;
	import com.layerglue.lib.application.structure.IStructuralData;
	
	public class ControllerHierarchyCreator
	{
		public var defaultController:Class;
		
		public var structureToControllerMap:StructureToContollerMap;
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
			var controllerClassRef:Class = structureToControllerMap.getClassReference(structuralData);
			
			var controller:IController = new controllerClassRef();
			controller.parent = parent;
			controller.structuralData = structuralData;
			
			//TODO: remove line below later
			//controller.controllerToViewClassMap = new WildSideControllerToViewMap();
			controller.viewClassReference = controllerToViewMap.getClassReference(controller);
			
			return controller;
		}
		
	}
}