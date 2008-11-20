package com.client.project.vo
{
	import com.layerglue.lib.application.structure.StructuralData;
	
	public class Contact extends StructuralData
	{
		public var imageUrl:String;
		public var address:String;
		public var email:String;
		
		public function Contact(id:String=null)
		{
			super(id);
		}

	}
}