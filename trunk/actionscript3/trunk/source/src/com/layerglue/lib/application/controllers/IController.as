package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.structure.IStructuralDataOwner;
	import com.layerglue.lib.application.views.IView;
	import com.layerglue.lib.base.core.IDestroyable;
	
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
		function get root():IController;
		
		function get viewClassReference():Class
		function set viewClassReference(value:Class):void
		
		/**
		 * Returns the view instance that this view's children should be created in. So for example
		 * if you were making a menu, this property might point to a button holder canvas.
		 */
		function get viewContainer():DisplayObjectContainer
		function set viewContainer(value:DisplayObjectContainer):void
		
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
		 * Which one of the child controllers is selected
		 */
		function get selectedChild():IController;
		
		/**
		 * Returns the deepest selected child in the controller hierarchy.
		 */
		function get deepestSelectedChild():IController;
		
		/**
		 * Destroys all the children of this controller.
		 */
		function destroyChildren():void
		
		
		function createView(shouldAdd:Boolean=false):IView
		
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