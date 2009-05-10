package com.layerglue.lib.base.utils
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class ReflectionUtils extends Object
	{
		public function ReflectionUtils()
		{
			super();
		}
		
		public static function getClassName(obj:*):String
		{
			return getQualifiedClassName(obj).split("::")[1];
		}
		
		public static function getFullyQualifiedClassName(obj:*):String
		{
			var arr:Array = getQualifiedClassName(obj).split("::");
			return arr[0] + "." + arr[1];
		}
		
		public static function getClassReference(obj:Object):Class
		{
			var name:String = getQualifiedClassName( obj );
			
			return getDefinitionByName( name ) as Class;
		}
		
		public static function isPrimitive(obj:*):Boolean
		{
			return	(obj is uint) || (obj is int) || (obj is Number) || (obj is String);
		}
	}
}