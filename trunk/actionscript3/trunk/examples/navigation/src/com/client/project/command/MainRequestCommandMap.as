package com.client.project.command
{
	import com.layerglue.lib.application.command.commands.StructuralDataNavigationCommand;
	import com.layerglue.lib.application.command.commands.URINavigationCommand;
	import com.layerglue.lib.application.command.requests.StructuralDataNavigationRequest;
	import com.layerglue.lib.application.command.requests.URINavigationRequest;
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
			addMapping(StructuralDataNavigationRequest, StructuralDataNavigationCommand);
			addMapping(URINavigationRequest, URINavigationCommand);
		}

	}
}