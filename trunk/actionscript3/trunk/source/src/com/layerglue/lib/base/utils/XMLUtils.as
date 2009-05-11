package com.layerglue.lib.base.utils
{
	public class XMLUtils extends Object
	{
		public function XMLUtils()
		{
			super();
		}
		
		public static function getNumItemsWithName(xml:XML, name:String):Number
		{
			return (xml.*.(localName() == name) as XMLList).length();
		}
	}
}