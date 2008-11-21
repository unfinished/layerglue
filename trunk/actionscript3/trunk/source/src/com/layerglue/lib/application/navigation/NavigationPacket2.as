package com.layerglue.lib.application.navigation
{
	import flash.events.EventDispatcher;
	import com.layerglue.lib.base.navigation.QueryString;
	
	public class NavigationPacket2 extends EventDispatcher
	{
		public var controllerStrand:Array;
		public var query:QueryString;
		
		public function NavigationPacket2(controllerStrand:Array, query:QueryString=null)
		{
			super();
			
			this.controllerStrand = controllerStrand;
			this.query = query;
		}
		
	}
}