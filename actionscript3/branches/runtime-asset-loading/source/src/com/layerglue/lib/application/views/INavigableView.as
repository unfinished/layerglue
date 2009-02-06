package com.layerglue.lib.application.views
{
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.base.core.IDestroyable;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	import mx.core.IChildList;
	import mx.core.IUIComponent;
	
	public interface INavigableView extends
		
		//Implementing interfaces needed by the framework
		IEventDispatcher,
		IDestroyable,
		
		// Bringing in line with Flex components
		// TODO: Could remove these - need to asses the frequency with which INavigableView needs to be cast. 
		IUIComponent,
		IChildList
	{
		/**
		 * The structural data for this view.
		 */
		function get structuralData():IStructuralData
		function set structuralData(value:IStructuralData):void
		
		function get childViewContainer():DisplayObjectContainer;
	}
}