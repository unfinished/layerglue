package com.client.project.maps
{
	import com.client.project.vo.Artist;
	import com.client.project.vo.Contact;
	import com.client.project.vo.Gallery;
	import com.client.project.vo.Home;
	import com.client.project.vo.Image;
	import com.client.project.vo.Site;
	import com.layerglue.flex3.base.collections.FlexCollection;
	import com.layerglue.lib.base.io.xml.XMLDeserializationMap;

	public class StructureDeserializationMap extends XMLDeserializationMap
	{
		public function StructureDeserializationMap()
		{
			super();
			
			// Below we add the mappings between XML nodes and classes.
			// The deserializer will use this map class as a lookup when turning the XML
			// heirarchy into actionscript objects.
			addMapping("children", FlexCollection);
			addMapping("site", Site);
			addMapping("home", Home);
			addMapping("gallery", Gallery);
			addMapping("artist", Artist);
			addMapping("image", Image);
			addMapping("contact", Contact);
		}
		
	}
}