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
		
		public function unnavigationCompleteHandler(controller:INavigableController):void
		{
			trace("NavigableApplicationController.unnavigationCompleteHandler: " + controller);
			
			//Start inwards navigation
			navigate();
		}
		
	}
}