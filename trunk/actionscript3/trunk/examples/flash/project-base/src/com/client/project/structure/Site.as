package com.client.project.structure
{
	import com.layerglue.lib.application.structure.StructuralData;
	import com.layerglue.lib.base.resources.ResourceCollection;

	public class Site extends StructuralData
	{
		public function Site(id:String=null)
		{
			super(id);
		}
		
		public var resourceCollection:ResourceCollection;
		
	}
}