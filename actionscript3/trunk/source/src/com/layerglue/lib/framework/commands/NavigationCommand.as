package com.layerglue.lib.framework.commands
{
	import com.layerglue.lib.base.commands.AbstractCommand;
	import com.layerglue.lib.base.requests.IRequest;
	import com.layerglue.lib.framework.requests.NavigationRequest;
	import com.layerglue.lib.framework.requests.RawNavigationRequest;

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
		
		private function get typedRequest():NavigationRequest
		{
			return request as NavigationRequest;
		}
		
		override public function execute(request:IRequest):void
		{
			super.execute(request);
			
			if(typedRequest.hideFromHistory)
			{
				(new RawNavigationRequest(typedRequest.destination.uri)).dispatch();
			}
			else
			{
				if(typedRequest.destination.uri != SWFAddress.getValue())
				{
					SWFAddress.setValue(typedRequest.destination.uri);
				}
			}
		}
	}
}