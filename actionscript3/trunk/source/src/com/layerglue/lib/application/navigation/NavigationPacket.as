package com.layerglue.lib.application.navigation
{
	import flash.events.EventDispatcher;

	public class NavigationPacket extends EventDispatcher
	{
		private var _address:String;
		
		public function get address():String
		{
			return _address;
		}
		
		public function set address(value:String):void
		{
			_address = value;
		}
		
		private var _query:QueryString;
		
		public function get query():QueryString
		{
			return _query;
		}
		
		public function set query(value:QueryString):void
		{
			_query = value;
		}
		
		private var _addressList:Array;
		
		public function get addressList():Array
		{
			return _addressList;
		}
		
		public function NavigationPacket(address:String, query:QueryString=null)
		{
			super();
			
			_addressList = processAddress(address);
			
			this.query = query;
		}
		
		protected function processAddress(address:String):Array
		{
			return address.split("/");
		}
		
		public function getUriNodeAtDepth(depth:int):String
		{
			return _addressList[depth];
		}
		
		public function get addressLength():int
		{
			return _addressList.length;
		}
		
	}
}