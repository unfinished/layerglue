package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.navigation.NavigationPacket;
	
	[Bindable]
	public interface INavigableApplicationController extends INavigableController, IApplicationController
	{
		function unnavigationCompleteHandler(controller:INavigableController):void
	}
}