package com.client.project.maps
{
	import com.client.project.structure.Site;
	import com.layerglue.lib.base.io.xml.XMLDeserializationMap;

	public class StructureDeserializationMap extends XMLDeserializationMap
	{
		public function StructureDeserializationMap()
		{
			super();
			
			// Below we add the mappings between XML nodes and classes.
			// The deserializer will use this map class as a lookup when turning the XML
			// hierarchy into actionscript objects.
			
			addMapping("children", Array);
			addMapping("site", Site);
		}
		
	}
}