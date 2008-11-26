package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.structure.IStructuralDataOwner;
	import com.layerglue.lib.application.views.IView;
	import com.layerglue.lib.base.core.IDestroyable;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	[Bindable]
	public interface INavigableController  extends
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
		//function get root():INavigableController;
		
		function get viewClassReference():Class
		function set viewClassReference(value:Class):void
		
		/**
		 * The container in which to create this controller's view, defaulting to the parent
		 * controller's view's childViewContainer.
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
		function get parent():INavigableController
		function set parent(value:INavigableController):void
		
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
		function get selectedChild():INavigableController;
		
		/**
		 * Destroys all the children of this controller.
		 */
		function destroyChildren():void
		
		
		function createView(shouldAdd:Boolean=false):void
		function addView():void
		
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
		
		function getChildByUriNode(string:String):INavigableController;
		function getChildById(string:String):INavigableController;
		
		function navigate():void;
		function unnavigateToCommonNode():void;
		
	}
}