package com.client.project.maps
{
	import com.layerglue.lib.application.commands.NavigationCommand;
	import com.layerglue.lib.application.commands.RawNavigationCommand;
	import com.layerglue.lib.application.requests.NavigationRequest;
	import com.layerglue.lib.application.requests.RawNavigationRequest;
	import com.layerglue.lib.base.maps.AbstractRequestCommandMap;
	
		
	public class MainRequestCommandMap extends AbstractRequestCommandMap
	{
		public function MainRequestCommandMap()
		{
			super();
			
			initialize();
		}
		
		override protected function initialize():void
		{
			addMapping(NavigationRequest, NavigationCommand);
			addMapping(RawNavigationRequest, RawNavigationCommand);
		}

	}
}