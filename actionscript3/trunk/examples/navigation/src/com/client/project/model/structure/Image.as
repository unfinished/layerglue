package com.client.project.vo
{
	import com.layerglue.lib.application.structure.StructuralData;
	
	public class Image extends StructuralData
	{
		public var url:String;
		
		public function Image(id:String=null)
		{
			super(id);
		}

	}
}