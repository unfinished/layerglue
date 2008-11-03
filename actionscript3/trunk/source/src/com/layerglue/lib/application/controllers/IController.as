package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.base.collections.HashMap;
	import com.layerglue.lib.base.core.IDestroyable;
	import com.layerglue.lib.application.maps.ControllerToViewMap;
	import com.layerglue.lib.application.structure.IStructuralDataOwner;
	import com.layerglue.lib.application.views.IView;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	[Bindable]
	public interface IController extends
		IEventDispatcher,
		IStructuralDataOwner,
		IDestroyable
	{
		/**
		 * Returns whether or not this is a root-level (primary) controller
		 */
		function isRoot():Boolean
		
		/**
		 * Returns the root controller
		 */
		function get root():IApplicationController;
		
		/**
		 * Returns the view instance that this controllers view should be created within.
		 * 
		 * In AbstractController this is implemented to default to parent.childViewContainer if no
		 * value has been set on the class.
		 */
		function get viewParent():DisplayObjectContainer
		function set viewParent(value:DisplayObjectContainer):void
		
		/**
		 * Returns the view instance that this view's children should be created in. So for example
		 * if you were making a menu, this property might point to a button holder canvas.
		 */
		function get childViewContainer():DisplayObjectContainer
		function set childViewContainer(value:DisplayObjectContainer):void
		
		/**
		 * Returns an instance of this controller instance's view
		 */
		function get view():IView
		function set view(value:IView):void
		
		/**
		 * Returns the parent controller of this instance
		 */
		function get parent():IController
		function set parent(value:IController):void
		
		/**
		 * Returns a list of child controllers contained by this instance
		 */
		function get children():Array
		function set children(value:Array):void
		
		/**
		 * Returns the depth of this instance within the controller hierarchy
		 */
		function get depth():uint
		
		/**
		 * Returns a Hashmap describing which views are associated to which controllers. This is used in the
		 * automatic creation of views by controllers.
		 */
		function get controllerToViewClassMap():ControllerToViewMap
		function set controllerToViewClassMap(value:ControllerToViewMap):void
		
		/**
		 * Returns a Hashmap describing which controllers are associated with which types of structral data.
		 * This is used in the automatic creation of controllers based on the deserialized
		 * structural data during application startup.
		 */
		function get structuralDataToControllerClassMap():HashMap
		function set structuralDataToControllerClassMap(value:HashMap):void
		
		/**
		 * Which one of the child controllers is selected
		 */
		function get selectedChild():IController;
		
		/**
		 * Returns the deepest selected child in the controller hierarchy.
		 */
		function get deepestSelectedChild():IController;
		
		/**
		 * Creates this controllers children based on a list of structural data objects.
		 */
		function createChildren(structuralDataCollection:Array=null, structuralDataToControllerClassMap:HashMap=null, controllerToViewClassMap:ControllerToViewMap=null):void
		
		/**
		 * Destroys all the children of this controller.
		 */
		function destroyChildren():void
		
		
		function createView(shouldAdd:Boolean=false):IView
		//function createView(viewParent:IView, controllerToViewClassMap:HashMap=null):void
		
		function destroyView():void;
		
		function viewPropertyChangeHandler(oldValue:IView, newValue:IView):void
		
		/**
		 * 
		 */
		function startTransitionIn():void
		
		/**
		 * 
		 */
		function startTransitionOut():void
	}
}