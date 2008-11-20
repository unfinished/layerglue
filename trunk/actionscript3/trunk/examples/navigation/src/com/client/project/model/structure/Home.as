package com.client.project.model.structure
{
	import com.layerglue.lib.application.structure.StructuralData;
	
	[Bindable]
	public class Home extends StructuralData
	{
		public var imageUrl:String;
		public var newsTitle:String;
		public var newsBody:String;
		public var featuredArtistTitle:String;
		public var featuredArtistBody:String;
		public var somethingTitle:String;
		public var somethingBody:String;
		
		public function Home(id:String=null)
		{
			super(id);
		}

	}
}