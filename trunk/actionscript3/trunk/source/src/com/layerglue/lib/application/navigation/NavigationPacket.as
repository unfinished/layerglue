package com.layerglue.lib.application.navigation
{
	import com.layerglue.lib.application.controllers.INavigableController;
	
	import flash.events.EventDispatcher;
	
	public class NavigationPacket extends EventDispatcher
	{
		public var controllerStrand:Array;
		public var query:QueryString;
		
		public function NavigationPacket(controllerStrand:Array, query:QueryString=null)
		{
			super();
			
			this.controllerStrand = controllerStrand;
			this.query = query;
		}
		
		public function getControllerAtDepth(depth:int):INavigableController
		{
			return controllerStrand[depth];
		}
		
		public function hasControllerAtDepth(depth:int):Boolean
		{
			return controllerStrand[depth] != null;
		}
		
		public function get strandLength():int
		{
			return controllerStrand.length;
		}
		
	}
}