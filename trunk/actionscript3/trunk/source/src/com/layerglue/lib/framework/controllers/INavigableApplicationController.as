package com.layerglue.lib.framework.controllers
{
	import com.layerglue.lib.framework.navigation.NavigationPacket;
	
	[Bindable]
	public interface INavigableApplicationController extends INavigableController
	{
		function processRawNavigation(uri:String):void;
		function unnavigationCompleteHandler(controller:INavigableController):void
		
		function get currentAddressPacket():NavigationPacket
		function get previousAddressPacket():NavigationPacket
	}
}