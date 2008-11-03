package com.layerglue.lib.application.views
{
	import com.layerglue.lib.application.controllers.INavigableApplicationController;
	
	public interface IApplicationView extends IView
	{
		function get controller():INavigableApplicationController;
		function set controller(value:INavigableApplicationController):void;
	}
}