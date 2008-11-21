package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.navigation.NavigationPacket;
	import com.layerglue.lib.application.navigation.NavigationPacket2;
	
	[Bindable]
	public interface INavigableController extends IController
	{
		function getChildByUriNode(string:String):INavigableController;
		function getChildById(string:String):INavigableController;
		
		function navigate():void;
		function unnavigateToCommonNode():void;
		
	}
}