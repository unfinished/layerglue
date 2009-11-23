package com.client.project.constants
{
	import flash.utils.describeType;
	
	public class LoadProportionConstants extends Object
	{
		public static const ROOT:int = 80;
		public static const GLOBAL_CONFIG:int = 1;
		public static const LOCALE_CONFIG:int = 1;
		public static const LOCALE_COPY:int = 1;
		public static const UNSUBSTITUED_STRUCTURE:int = 1;
		public static const REGIONAL_COMPILED_FONT:int = 10;
		public static const RUNTIME_ASSETS:int = 10;
		 
		public function LoadProportionConstants()
		{
			super();
		}
		
		public static function get total():Number
		{
			var classAsXML:XML = describeType(LoadProportionConstants);
			var constants:XMLList = classAsXML.constant
			var n:Number = 0;
			
			for each(var constantNode:XML in constants)
			{
				if(constantNode.@type == "int")
				{					
					n += LoadProportionConstants[constantNode.@name];
				}
			}
			
			return n;
		}
	}
}