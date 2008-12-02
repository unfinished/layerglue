package com.client.project.model.structure
{
	import com.layerglue.lib.application.structure.StructuralData;
	
	[Bindable]
	public class ArtistImage extends StructuralData
	{
		public var basePath:String;
		
		public function ArtistImage(id:String=null)
		{
			super(id);
		}
		
		public function get largeImagePath():String
		{
			return basePath + "-large.jpg";
		}
		
		public function get smallImagePath():String
		{
			return basePath + "-small.jpg";
		}

	}
}