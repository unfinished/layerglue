package com.layerglue.lib.application.views
{
	import com.layerglue.lib.application.structure.IStructuralDataOwner;
	import com.layerglue.lib.base.core.IDestroyable;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	import mx.core.IChildList;
	import mx.core.IUIComponent;
	
	public interface INavigableView extends
		
		//Implementing interfaces needed by the framework
		IEventDispatcher,
		IStructuralDataOwner,
		IDestroyable,
		
		//Bringing in line with Flex components
		IUIComponent,
		IChildList
	{
		function get childViewContainer():DisplayObjectContainer;
	}
}