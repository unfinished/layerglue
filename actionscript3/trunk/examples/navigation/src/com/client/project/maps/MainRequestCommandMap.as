package com.client.project.maps
{
	import com.layerglue.lib.application.commands.StructuralDataNavigationCommand;
	import com.layerglue.lib.application.commands.URINavigationCommand;
	import com.layerglue.lib.application.requests.StructuralDataNavigationRequest;
	import com.layerglue.lib.application.requests.URINavigationRequest;
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