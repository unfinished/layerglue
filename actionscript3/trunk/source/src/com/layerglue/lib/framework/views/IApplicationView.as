package com.layerglue.lib.framework.views
{
	import com.layerglue.lib.framework.controllers.INavigableApplicationController;
	
	public interface IApplicationView extends IView
	{
		function get controller():INavigableApplicationController;
		function set controller(value:INavigableApplicationController):void;
	}
}