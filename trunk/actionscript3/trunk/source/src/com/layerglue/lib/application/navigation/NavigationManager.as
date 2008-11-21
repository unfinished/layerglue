package com.layerglue.lib.application.navigation
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import com.layerglue.lib.application.controllers.INavigableController;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.base.utils.StringUtils;
	
	import flash.events.EventDispatcher;
	
	public class NavigationManager extends EventDispatcher
	{
		public var rootController:INavigableController;
		
		/**
		 * TODO This isn't related to browser history and is purely a list of navigation locations
		 * that have been processed by the system - If the user clicks back in the browser another
		 * item will be added to this rather than one being removed from the end of the list.
		 */
		private var _history:NavigationHistory;
		
		public function get history():NavigationHistory
		{
			return _history;
		}
		
		public function NavigationManager(rootController:INavigableController)
		{
			super();
			
			_history = new NavigationHistory();
			
			this.rootController = rootController;
			
			initializeSWFAddress()
		}
		
		private static var _instance:NavigationManager;
		
		public static function initialize(rootController:INavigableController):NavigationManager
		{
			if(!_instance)
			{
				_instance = new NavigationManager(rootController);
			}
			
			return _instance;
		}
		
		public static function getInstance():NavigationManager
		{
			if(!_instance)
			{
				throw new Error("Attempted access of NavigationManager singleton before initialization.");
			}
			return _instance;
		}
		
		private function initializeSWFAddress():void
		{
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, swfAddressChangeHandler);
		}
		
		private function swfAddressChangeHandler(event:SWFAddressEvent):void
		{
			//Create new style navpackets here
			processURINavigation(event.path);
		}
		
		public function processURINavigation(uri:String):void
		{
			trace("NavigationManager.processURINavigation: " + uri);
			
			processNavigation(getStructuralDataStrandFromURI(uri));
		}
		
		public function processStructuralNavigation(structuralData:IStructuralData):void
		{
			trace("NavigationManager.processStructuralNavigation: " + structuralData + " - " + structuralData.uri);
			
			processNavigation(getStructuralDataStrandFromStructuralData(structuralData));
		}
		
		protected function processNavigation(structuralDataStrand:Array):void
		{
			history.addItem(structuralDataStrand[structuralDataStrand.length-1] as IStructuralData);
			
			trace("NavigationManager.processNavigation: " + getControllerStrandFromStructuralDataStrand(structuralDataStrand));
			
			//Call navigate on rootController passing in packet
			//rootController.navigate2(packet);
		}
		
		public function getControllerStrandFromStructuralDataStrand(structuralDataStrand:Array):Array
		{
			var controllerStrand:Array = [rootController];
			var currentController:INavigableController = rootController;
			
			for(var i:int=1 ; i<structuralDataStrand.length ; i++)
			{
				var sd:IStructuralData = structuralDataStrand[i];
				
				currentController = currentController.getChildById(sd.id);
				controllerStrand.push(currentController);
			}
			
			return validateControllerStrand(controllerStrand);
		}
		
		private function validateControllerStrand(controllerStrand:Array):Array
		{
			var deepestController:INavigableController = controllerStrand[controllerStrand.length-1];
			
			if(deepestController.structuralData.defaultChild)
			{
				//TODO make a getChildByStructuralData and replace here
				var nextController:INavigableController = deepestController.getChildById(deepestController.structuralData.defaultChildId);
				controllerStrand.push(nextController);
				return validateControllerStrand(controllerStrand);
			}
			
			return controllerStrand;
		}
		
		public function getStructuralDataStrandFromStructuralData(structuralData:IStructuralData):Array
		{
			var structuralDataStrand:Array = [structuralData];
			
			while(structuralData.parent)
			{
				structuralDataStrand.push(structuralData.parent);
				structuralData = structuralData.parent;
			}
			
			return structuralDataStrand.reverse();
		}
		
		public function getStructuralDataStrandFromURI(uri:String):Array
		{
			var structuralDataStrand:Array = [rootController.structuralData];
			var split:Array = StringUtils.removeTrailingSlash(uri).split("/");
			var currentStructuralData:IStructuralData = rootController.structuralData;
			
			for(var i:int=1 ; i<split.length ; i++)
			{
				var uriNode:String = split[i];
				
				currentStructuralData = currentStructuralData.getChildById(uriNode)
				structuralDataStrand.push(currentStructuralData)
			}
			
			return structuralDataStrand;
		}
		
	}
}