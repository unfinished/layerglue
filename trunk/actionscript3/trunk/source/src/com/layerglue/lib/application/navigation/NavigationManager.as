package com.layerglue.lib.application.navigation
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import com.layerglue.lib.application.command.requests.StructuralDataNavigationRequest;
	import com.layerglue.lib.application.controllers.INavigableController;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.base.utils.StringUtils;
	
	import flash.events.EventDispatcher;
	
	[Bindable]
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
		}
		
		public function connectBrowserNavigation():void
		{
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, swfAddressChangeHandler);
		}
		
		public function disconnectBrowserNavigation():void
		{
			SWFAddress.removeEventListener(SWFAddressEvent.CHANGE, swfAddressChangeHandler);
		}
		
		private function swfAddressChangeHandler(event:SWFAddressEvent):void
		{
			//TODO Investigate swf address parameters and changing how query is deserialized
			//Create new style navpackets here
			processURINavigation(event.value);
		}
		
		public function processURINavigation(uri:String):void
		{
			trace(">>>>>>> NavigationManager.processURINavigation: " + uri);
			
			var split:Array = uri.split("?");
			var addressPortion:String = split[0];
			var queryPortion:String = split[1];
			
			var structuralDataStrand:Array = getStructuralDataStrandFromURI(addressPortion);
			var controllerStrand:Array = getControllerStrandFromStructuralDataStrand(structuralDataStrand);
			var packet:NavigationPacket = new NavigationPacket(controllerStrand)
			
			if(queryPortion)
			{
				packet.query = new QueryString(queryPortion);	
			}
			
			processNavigation(packet);
		}
		
		public function processStructuralDataNavigation(structuralData:IStructuralData):void
		{
			trace(">>>>>>> NavigationManager.processStructuralNavigation: " + structuralData + " - " + structuralData.uri);
			
			var structuralDataStrand:Array = getStructuralDataStrandFromStructuralData(structuralData);
			var controllerStrand:Array = getControllerStrandFromStructuralDataStrand(structuralDataStrand);
			var packet:NavigationPacket = new NavigationPacket(controllerStrand);
			
			processNavigation(packet);
		}
		
		protected function processNavigation(packet:NavigationPacket):void
		{
			setCurrentAddress(packet);
			
			//Add the deepest structural data to the history
			var deepestController:INavigableController = packet.controllerStrand[packet.controllerStrand.length-1] as INavigableController;
			history.addItem(deepestController.structuralData);
			trace(">>>>>>> NavigationManager.processNavigation: " + deepestController.structuralData.uri);
			
			
			var deepest:INavigableController = deepestSelectedController;
			
			if(deepest && deepest != rootController)
			{
				//trace("Trying to unnavigate from: " + deepestSelectedController.structuralData.uri);
				(deepest as INavigableController).unnavigate();
			}
			else
			{
				//Call navigate on rootController passing in packet
				rootController.navigate();
			}
		}
		
		public function get deepestSelectedController():INavigableController
		{
			var controller:INavigableController = rootController;
			
			while(controller.selectedChild)
			{
				if(controller.selectedChild)
				{
					controller = controller.selectedChild;
				}
				else
				{
					break;
				}
			}
			return controller;
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
		
		// Adds any default child's onto the place we're about to navigate
		// TODO: rename this? it's not really validating, it's adding default childs
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
				
				currentStructuralData = currentStructuralData.getChildByUriNode(uriNode)
				structuralDataStrand.push(currentStructuralData)
			}
			
			return structuralDataStrand;
		}
		
		public function unnavigationCompleteHandler(commonController:INavigableController):void
		{
			trace("NavigationManager.unnavigationCompleteHandler - commonController: " + commonController);
			
			// Start inwards navigation
			// Should inwards navigation start from root controller or common-unnavigable controller?
			//rootController.navigate();
			commonController.navigate();
		}
		
		//--------------------
		
		private var _currentAddressPacket:NavigationPacket;
		
		public function get currentAddressPacket():NavigationPacket
		{
			return _currentAddressPacket;
		}
		
		public function setCurrentAddress(value:NavigationPacket):void
		{
			_currentAddressPacket = value;
		}
		
		public function doFirstNavigation():void
		{
			
			var arr:Array = getStructuralDataStrandFromURI(SWFAddress.getPath());
			var sd:IStructuralData = arr[arr.length-1] as IStructuralData;
			
			trace("doFirstNavigation: "+sd);
			(new StructuralDataNavigationRequest(sd, true)).dispatch();
		}
	}
}