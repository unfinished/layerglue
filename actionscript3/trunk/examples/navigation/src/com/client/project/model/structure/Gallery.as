package com.client.project.model.structure
{
	import com.layerglue.lib.application.structure.StructuralData;
	
	[Bindable]
	public class Gallery extends StructuralData
	{
		public var bodyCopy:String;
		
		public function Gallery(id:String=null)
		{
			super(id);
		}

	}
}