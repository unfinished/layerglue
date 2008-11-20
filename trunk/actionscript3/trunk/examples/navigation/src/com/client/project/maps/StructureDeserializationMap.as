package com.client.project.maps
{
	import com.client.project.vo.Contact;
	import com.client.project.vo.Gallery;
	import com.client.project.vo.Home;
	import com.client.project.vo.Image;
	import com.client.project.vo.Page;
	import com.client.project.vo.StructureRoot;
	import com.layerglue.lib.base.io.xml.XMLDeserializationMap;

	public class StructureDeserializationMap extends XMLDeserializationMap
	{
		public function StructureDeserializationMap()
		{
			super();
			
			// Below we add the mappings between XML nodes and classes.
			// The deserializer will use this map class as a lookup when turning the XML
			// heirarchy into actionscript objects.
			addMapping("home", Home);
			addMapping("children", Array);
			addMapping("structureRoot", StructureRoot);
			addMapping("gallery", Gallery);
			addMapping("page", Page);
			addMapping("image", Image);
			addMapping("contact", Contact);
		}
		
	}
}