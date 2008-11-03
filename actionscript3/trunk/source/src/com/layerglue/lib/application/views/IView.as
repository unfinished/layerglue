package com.layerglue.lib.application.views
{
	import com.layerglue.lib.base.core.IDestroyable;
	import com.layerglue.lib.application.structure.IStructuralDataListener;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	import mx.core.IChildList;
	import mx.core.IUIComponent;
	
	public interface IView extends
		
		//Implementing interfaces needed by the framework
		IStructuralDataListener,
		IDestroyable,
		IEventDispatcher,
		
		//Bringing in line with Flex components
		IUIComponent,
		IChildList
	{
		function get childViewContainer():DisplayObjectContainer;
		
		function startTransitionIn():void
		function startTransitionOut():void
		function stopTransition():void;
	}
}