package com.layerglue.lib.base.resources 
{
	import com.layerglue.lib.base.io.xml.ISelfDeserializer;

	/**
	 * @author Jamie Copeland
	 */
	public class StringResource extends Object implements IResourceItem, ISelfDeserializer
	{
		public function StringResource()
		{
			super();
		}
		
		private var _id:String;
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		private var _value:String;	
		
		public function get value():String
		{
			return _value;
		}
				
		public function set value(value:String):void
		{
			_value = value;
		}
		
		public function deserialize(xml:XML):*
		{
			id = xml.@id;
			value = xml.valueOf();
			return this
		}
		
	}
}
