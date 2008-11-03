package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.navigation.NavigationPacket;
	
	[Bindable]
	public interface INavigableApplicationController extends INavigableController
	{
		function processRawNavigation(uri:String):void;
		function unnavigationCompleteHandler(controller:INavigableController):void
		
		function get currentAddressPacket():NavigationPacket
		function get previousAddressPacket():NavigationPacket
	}
}