package com.client.project.model.structure
{
	import com.layerglue.lib.application.structure.StructuralData;
	
	[Bindable]
	public class Image extends StructuralData
	{
		public var url:String;
		
		public function Image(id:String=null)
		{
			super(id);
		}

	}
}