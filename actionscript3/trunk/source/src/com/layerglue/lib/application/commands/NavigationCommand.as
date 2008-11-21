package com.layerglue.lib.application.commands
{
	import com.asual.swfaddress.SWFAddress;
	import com.layerglue.lib.application.navigation.NavigationManager;
	import com.layerglue.lib.application.requests.StructuralNavigationRequest;
	import com.layerglue.lib.application.requests.RawNavigationRequest;
	import com.layerglue.lib.base.commands.AbstractCommand;
	import com.layerglue.lib.base.requests.IRequest;

	/**
	 * <p>A command dealing with navigation requests by the system.</p>
	 * 
	 * <p>Note: If navigation needs to be hidden from history a RawNavigationRequest is dispatched
	 * immediately instead of going through SWFAddress.</p>
	 */
	public class NavigationCommand extends AbstractCommand
	{
		public function NavigationCommand()
		{
			super();
		}
		
		private function get typedRequest():StructuralNavigationRequest
		{
			return request as StructuralNavigationRequest;
		}
		
		override public function execute(request:IRequest):void
		{
			super.execute(request);
			
			if(typedRequest.hideFromBrowser)
			{
				(new RawNavigationRequest(typedRequest.destination.uri)).dispatch();
				
				//NavigationManager.getInstance().processStructuralNavigation(typedRequest.destination);
			}
			else
			{
				if(typedRequest.destination.uri != SWFAddress.getValue())
				{
					//TODO: Check that entire structural data chain has valid uri gellers
					SWFAddress.setValue(typedRequest.destination.uri);
				}
			}
		}
	}
}