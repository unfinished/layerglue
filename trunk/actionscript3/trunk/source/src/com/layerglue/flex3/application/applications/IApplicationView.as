package com.layerglue.flex3.application.applications
{
	import com.layerglue.lib.application.controllers.INavigableApplicationController;
	import com.layerglue.lib.application.views.IView;
	
	public interface IApplicationView extends IView
	{
		function get controller():INavigableApplicationController;
		function set controller(value:INavigableApplicationController):void;
	}
}