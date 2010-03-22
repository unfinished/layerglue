package com.client.project.maps
{
	import com.layerglue.lib.base.resources.TextResource;
	import com.layerglue.lib.base.resources.XMLResourceItem;
	import com.layerglue.lib.base.resources.SWFResourceItem;
	import com.layerglue.lib.base.resources.ImageResourceItem;
	import com.layerglue.lib.base.resources.ResourceCollection;
	import com.client.project.structure.Site;
	import com.layerglue.lib.base.collections.ArrayExt;
	import com.layerglue.lib.base.io.xml.XMLDeserializationMap;

	public class StructureDeserializationMap extends XMLDeserializationMap
	{
		public function StructureDeserializationMap()
		{
			super();
			
			// Below we add the mappings between XML nodes and classes.
			// The deserializer will use this map class as a lookup when turning the XML
			// hierarchy into actionscript objects.
			
			addMapping("children", ArrayExt);
			addMapping("site", Site);
			
			
			addMapping("items", Array);
			addMapping("resourceCollection", ResourceCollection);
			addMapping("imageResource", ImageResourceItem);
			addMapping("swfResource", SWFResourceItem);
			addMapping("xmlResource", XMLResourceItem);
			addMapping("textResource", TextResource);
			
		}
		
	}
}