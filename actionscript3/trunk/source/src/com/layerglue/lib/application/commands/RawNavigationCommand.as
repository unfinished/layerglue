package com.layerglue.lib.application.commands
{
	import com.layerglue.lib.application.requests.RawNavigationRequest;
	import com.layerglue.lib.base.commands.AbstractCommand;
	import com.layerglue.lib.base.requests.IRequest;
	
	public class RawNavigationCommand extends AbstractCommand
	{
		public function RawNavigationCommand()
		{
			super();
		}
		
		private function get typedRequest():RawNavigationRequest
		{
			return request as RawNavigationRequest;
		}
		
		override public function execute(request:IRequest):void
		{
			super.execute(request);
			//NavigationManager.getInstance().processStructuralNavigation(typedRequest.
		}
	}
}
