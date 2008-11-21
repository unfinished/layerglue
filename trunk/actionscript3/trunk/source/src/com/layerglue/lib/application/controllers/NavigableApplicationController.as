package com.layerglue.lib.application.controllers
{
	import com.asual.swfaddress.SWFAddress;
	import com.layerglue.lib.application.events.NavigableApplicationControllerEvent;
	import com.layerglue.lib.application.navigation.NavigationPacket;
	import com.layerglue.lib.application.requests.RawNavigationRequest;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.IView;

	public class NavigableApplicationController extends AbstractNavigableController implements INavigableApplicationController
	{
		public function NavigableApplicationController(structuralData:IStructuralData, view:IView)
		{
			super();
			
			this.structuralData = structuralData;
			view.structuralData = structuralData;
		}
		
		private var _currentAddressPacket:NavigationPacket;
		
		[Bindable (event="currentAddressChange")]
		public function get currentAddressPacket():NavigationPacket
		{
			return _currentAddressPacket;
		}
		
		private var _previousAddressPacket:NavigationPacket;
		
		[Bindable (event="previousAddressChange")]
		public function get previousAddressPacket():NavigationPacket
		{
			return _previousAddressPacket;
		}
		
		private var _navigationCounter:int;
		
		[Bindable (event="navigationCounterChange")]
		public function get navigationCounter():int
		{
			return _navigationCounter;
		}
		
		protected function setCurrentAddress(value:NavigationPacket):void
		{
			_currentAddressPacket = value;
		}
		
		protected function setPreviousAddress(value:NavigationPacket):void
		{
			_previousAddressPacket = value;
		}
		
		protected function incrementNavigationCounter():void
		{
			_navigationCounter++;
		}
		
		/**
		 * This is the method that will recieve incoming raw navigation requests from the navigation
		 * system - coming either from either a purely internal navigation or one that has passed
		 * through the SWFAddress system.
		 * 
		 * This class should be overriden in subclasses to perform site navigation BUT A CALL BACK
		 * TO <code>super.processRawNavigation(uri)</code> MUST ALWAYS BE MADE.
		 */
		public function processRawNavigation(uri:String):void
		{
			incrementNavigationCounter();
			setPreviousAddress(currentAddressPacket);
			setCurrentAddress(new NavigationPacket(uri));
			
			dispatchEvent(new NavigableApplicationControllerEvent(NavigableApplicationControllerEvent.PREVIOUS_ADDRESS_CHANGE));
			dispatchEvent(new NavigableApplicationControllerEvent(NavigableApplicationControllerEvent.CURRENT_ADDRESS_CHANGE));
			dispatchEvent(new NavigableApplicationControllerEvent(NavigableApplicationControllerEvent.NAVIGATION_COUNTER_CHANGE));
		}
		
		public function unnavigationCompleteHandler(controller:INavigableController):void
		{
			//startTransitionIn();
			trace("NavigableApplicationController.unnavigationCompleteHandler: " + controller);
			
			//Start inwards navigation
			startNavigation(currentAddressPacket);
		}
		
		protected function startNavigation(packet:NavigationPacket):void
		{
			navigate(packet);
		}
		
		//TODO Look at how this works as a defautl
		public function doFirstNavigation():void
		{
			//(new RawNavigationRequest(SWFAddress.getValue())).dispatch();
			//setTimeout(test, 10);
			test();
		}
		
		private function test():void
		{
			(new RawNavigationRequest(SWFAddress.getValue())).dispatch();
		}
		
		public function getControllerHierarchyStrand(packet:NavigationPacket):Array
		{
			//TODO Tidy this up and look at how packet.hasChildAtDepth(0) always returns false
			  
			var strand:Array = [];
			var controller:INavigableController = this;
			var depth:int = 1;
			
			//trace(">>>>>>>>>>>>>>>>>>>>>> getControllerHierarchyStrand: " + packet.uri);
			
			while(packet.hasChildAtDepth(depth))
			{
				controller = controller.getChildByUriNode(packet.getUriNodeStringAtDepth(depth));
				
				//Deals with 404 references returning null for the controller
				if(controller)
				{
					strand.push(controller);
					depth++;
				}
				else
				{
					break;
				}
				
			}
			strand.unshift(this);
			
			return strand
		}
		
	}
}