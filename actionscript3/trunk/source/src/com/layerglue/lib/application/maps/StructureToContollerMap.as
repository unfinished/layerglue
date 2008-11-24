package com.layerglue.lib.application.maps
{
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.base.utils.ReflectionUtils;
	
	public class StructureToContollerMap extends ClassMap
	{
		public function StructureToContollerMap()
		{
			super();
		}
		
		public function getClassReference(structuralData:IStructuralData):Class
		{
			var idMapping:Class = getFromIdMap(structuralData.structuralDataToControllerMapId)
			
			if(idMapping)
			{
				return idMapping;
			}
			else
			{
				return getFromClassReferenceMap(ReflectionUtils.getClassReference(structuralData));
			}
		}
		
	}
}