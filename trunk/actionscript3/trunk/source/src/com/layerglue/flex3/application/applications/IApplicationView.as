package com.layerglue.flex3.application.applications
{
	import com.layerglue.lib.application.controllers.INavigableController;
	import com.layerglue.lib.application.views.INavigableView;
	
	public interface IApplicationView extends INavigableView
	{
		function get controller():INavigableController;
		function set controller(value:INavigableController):void;
	}
}