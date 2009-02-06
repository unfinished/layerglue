package com.layerglue.lib.application.maps
{
	import com.layerglue.lib.application.command.commands.StructuralDataNavigationCommand;
	import com.layerglue.lib.application.command.commands.URINavigationCommand;
	import com.layerglue.lib.application.command.requests.StructuralDataNavigationRequest;
	import com.layerglue.lib.application.command.requests.URINavigationRequest;
	import com.layerglue.lib.base.maps.FrontControllerMap;

	public class LayerGlueFrontControllerMap extends FrontControllerMap
	{
		public function LayerGlueFrontControllerMap()
		{
			super();
		}
		
		override protected function initialize():void
		{
			addMapping(StructuralDataNavigationRequest, StructuralDataNavigationCommand);
			addMapping(URINavigationRequest, URINavigationCommand);
		}
		
	}
}