package com.layerglue.lib.framework.controllers
{
	import com.asual.swfaddress.SWFAddress;
	import com.layerglue.lib.framework.events.NavigableApplicationControllerEvent;
	import com.layerglue.lib.framework.navigation.NavigationPacket;
	import com.layerglue.lib.framework.requests.RawNavigationRequest;
	import com.layerglue.lib.framework.structure.IStructuralData;
	import com.layerglue.lib.framework.views.IView;

	public class NavigableApplicationController extends ApplicationController implements INavigableApplicationController
	{
		public function NavigableApplicationController(structuralData:IStructuralData, view:IView)
		{
			super(structuralData, view);
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
			//SWFAddress.setTitle(getPageTitleFromPacket(packet));
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
		
	}
}