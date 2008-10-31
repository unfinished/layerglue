package com.layerglue.lib.framework.controllers
{
	import com.layerglue.lib.framework.navigation.NavigationPacket;
	
	[Bindable]
	public interface INavigableController extends IController
	{
		function navigate(packet:NavigationPacket):void;
		function unnavigateToCommonNode(packet:NavigationPacket):void;
		function getChildByUriNode(string:String):INavigableController;
		function getChildById(string:String):INavigableController;
	}
}