package com.layerglue.lib.application.commands
{
	import com.asual.swfaddress.SWFAddress;
	import com.layerglue.lib.application.navigation.NavigationManager;
	import com.layerglue.lib.application.requests.URINavigationRequest;
	import com.layerglue.lib.base.commands.AbstractCommand;
	import com.layerglue.lib.base.requests.IRequest;

	public class URINavigationCommand extends AbstractCommand
	{
		public function URINavigationCommand()
		{
			super();
		}
		
		private function get typedRequest():URINavigationRequest
		{
			return request as URINavigationRequest;
		}
		
		override public function execute(request:IRequest):void
		{
			super.execute(request);
			
			if(typedRequest.hideFromBrowser)
			{
				NavigationManager.getInstance().processURINavigation(typedRequest.uri);
			}
			else
			{
				if(typedRequest.uri != SWFAddress.getValue())
				{
					SWFAddress.setValue(typedRequest.uri);
				}
			}
		}
	}
}