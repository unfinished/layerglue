package com.layerglue.flex3.application.applications
{
	import com.layerglue.lib.application.controllers.INavigableController;
	import com.layerglue.lib.application.events.StructuralDataListenerEvent;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.base.command.FrontController;
	import com.layerglue.lib.base.events.DestroyEvent;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.core.Application;
	[Bindable]
	public class ApplicationView extends Application implements IApplicationView
	{
		
		public function ApplicationView():void
		{
			super();
			
			initializeRequestCommandConnector();
			
			startup();
		}
		
		protected function startup():void
		{
			initializeApplicationController();
		}
		
		protected function initializeApplicationController():void
		{
			//This should be overridden in subclasses
		}
		
		private var _controller:INavigableController;
		
		public function get controller():INavigableController
		{
			return _controller;
		}
		
		public function set controller(value:INavigableController):void
		{
			_controller = value;
		}
		
		private var _structuralData:IStructuralData;
		
		public function get structuralData():IStructuralData
		{
			return _structuralData;
		}

		public function set structuralData(value:IStructuralData):void
		{
			_structuralData = value;
		}
		
		private var _childViewContainer:DisplayObjectContainer
		
		public function get childViewContainer():DisplayObjectContainer
		{
			return _childViewContainer;
		}
		
		public function set childViewContainer(value:DisplayObjectContainer):void
		{
			_childViewContainer = value;
		}
		
		public function startTransitionIn():void
		{
			trace("########## ApplicationView.startTransitionIn");
		}
		
		public function startTransitionOut():void
		{
			trace("########## ApplicationView.startTransitionOut");
		}
		
		public function stopTransition():void
		{
		}
		
		protected function initializeRequestCommandConnector():void
		{
			FrontController.initialize([]);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
		}
		
		public function destroy():void
		{			
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}	
	}
}