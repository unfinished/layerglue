package com.client.project.maps
{
	import com.client.project.model.structure.Artist;
	import com.client.project.model.structure.Contact;
	import com.client.project.model.structure.Gallery;
	import com.client.project.model.structure.Home;
	import com.client.project.model.structure.Image;
	import com.client.project.model.structure.Site;
	import com.layerglue.flex3.base.collections.FlexCollection;
	import com.layerglue.lib.base.io.xml.XMLDeserializationMap;

	public class ProjectStructureDeserializationMap extends XMLDeserializationMap
	{
		public function ProjectStructureDeserializationMap()
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