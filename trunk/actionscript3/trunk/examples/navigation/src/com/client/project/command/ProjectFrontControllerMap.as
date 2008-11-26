package com.client.project.command
{
	import com.layerglue.lib.application.maps.LayerGlueFrontControllerMap;
	
		
	public class ProjectFrontControllerMap extends LayerGlueFrontControllerMap
	{
		public function ProjectFrontControllerMap()
		{
			super();
			
			initialize();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			//Put in project specific mappings here
		}

	}
}