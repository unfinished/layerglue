package com.client.project.model.structure
{
	import com.layerglue.lib.application.structure.StructuralData;
	import com.client.project.model.domain.Footer;
	
	[Bindable]
	public class Site extends StructuralData
	{
		public var footer:Footer;
		
		public function Site(id:String=null)
		{
			super(id);
		}
		
	}
}