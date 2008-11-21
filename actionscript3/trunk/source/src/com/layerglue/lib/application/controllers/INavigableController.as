package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.navigation.NavigationPacket;
	import com.layerglue.lib.application.navigation.NavigationPacket2;
	
	[Bindable]
	public interface INavigableController extends IController
	{
		function navigate(packet:NavigationPacket):void;
		function unnavigateToCommonNode(packet:NavigationPacket):void;
		function getChildByUriNode(string:String):INavigableController;
		function getChildById(string:String):INavigableController;
		
		function navigate2():void;
		function unnavigateToCommonNode2():void;
		
	}
}