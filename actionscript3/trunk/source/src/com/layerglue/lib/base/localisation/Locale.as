package com.layerglue.lib.base.localisation
{
	import com.layerglue.lib.base.resources.PropertyCollection;
	
	import mx.core.Application;

	public class Locale extends PropertyCollection
	{
		public function Locale()
		{
			super();
			
		}
		
		//TODO change this over so its not reliant on Flex framework
		public static function get code():String
		{
			return Application.application.parameters.locale ?
						Application.application.parameters.locale : "en-gb";
		}
		
		public function get textDirection():String
		{
			var d:String = get('textDirection') ? get('textDirection') : "ltr";
			return d;
		}
		
		/*
		public function getStringById()
		{
			
		}
		
		public function getBitmapDataById()
		{
			
		}
		
		public function getAutoItemById()
		{
			
		}
		*/
	}
}