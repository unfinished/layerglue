package com.layerglue.lib.application.maps
{
	import com.layerglue.lib.application.controllers.INavigableController;
	import com.layerglue.lib.base.utils.ReflectionUtils;
	
	public class ControllerToViewMap extends ClassMap
	{
		public function ControllerToViewMap()
		{
			super();
		}
		
		public function getClassReference(controller:INavigableController):Class
		{
			var idMapping:Class = getFromIdMap(controller.structuralData.controllerToViewMapId)
			
			if(idMapping)
			{
				return idMapping;
			}
			else
			{
				return getFromClassReferenceMap(ReflectionUtils.getClassReference(controller));
			}
		}
		
	}
}