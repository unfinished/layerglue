package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.structure.IStructuralDataOwner;
	import com.layerglue.lib.application.views.IView;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	[Bindable]
	public interface INavigableController  extends
		IEventDispatcher,
		IStructuralDataOwner
	{
		/**
		 * Returns whether or not this is a root-level (primary) controller
		 */
		function isRoot():Boolean
		
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
		
		function createView(shouldAdd:Boolean=false):void
		
		function destroyView():void;
		
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