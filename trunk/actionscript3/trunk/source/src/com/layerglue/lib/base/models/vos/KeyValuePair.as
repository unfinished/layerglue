package com.layerglue.lib.base.models.vos
{
	public class KeyValuePair extends Object
	{
		public function KeyValuePair()
		{
			super();
		}
		
		private var _key:String;

		public function get key():String
		{
			return _key;
		}

		public function set key(value:String):void
		{
			_key = value;
		}
		
		private var _value:Object;

		public function get value():Object
		{
			return _value;
		}

		public function set value(value:Object):void
		{
			_value = value;
		}
	}
}