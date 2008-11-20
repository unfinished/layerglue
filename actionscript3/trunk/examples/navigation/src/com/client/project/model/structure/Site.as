package com.client.project.vo
{
	import com.layerglue.lib.application.structure.StructuralData;
	
	[Bindable]
	public class Site extends StructuralData
	{
		public var copyright:String;
		
		public function Site(id:String=null)
		{
			super(id);
		}
		
	}
}