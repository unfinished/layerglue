package com.layerglue.flex3.application.applications
{
	import com.layerglue.lib.application.controllers.INavigableApplicationController;
	import com.layerglue.lib.application.events.StructuralDataListenerEvent;
	import com.layerglue.lib.application.proxies.StructuralDataListenerUtil;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.base.core.RequestCommandConnector;
	import com.layerglue.lib.base.events.DestroyEvent;
	import com.layerglue.lib.base.events.SelectionEvent;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.core.Application;
	[Bindable]
	public class ApplicationView extends Application implements IApplicationView
	{
		private var _structuralDataListenerUtil:StructuralDataListenerUtil;
		
		public function ApplicationView():void
		{
			super();
			
			_structuralDataListenerUtil = new StructuralDataListenerUtil(this);
			
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
		
		private var _controller:INavigableApplicationController;
		
		public function get controller():INavigableApplicationController
		{
			return _controller;
		}
		
		public function set controller(value:INavigableApplicationController):void
		{
			_controller = value;
		}
		
		[Bindable(event="structuralDataChange")]
		public function get structuralData():IStructuralData
		{
			return _structuralDataListenerUtil.structuralData;
		}

		public function set structuralData(value:IStructuralData):void
		{
			_structuralDataListenerUtil.structuralData = value;
			
			trace("ApplicationView set structuralData");
			dispatchEvent(new StructuralDataListenerEvent(StructuralDataListenerEvent.STRUCTURAL_DATA_CHANGE));
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
		
		public function structuralDataPropertyChangeHandler(oldStructuralData:IStructuralData, newStructuralData:IStructuralData):void
		{
		}
		
		public function structuralDataSubselectionChangeHandler(event:SelectionEvent):void
		{
		}
		
		public function structuralDataSelectionStatusChangeHandler(event:SelectionEvent):void
		{
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
			RequestCommandConnector.initialize([]);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
		}
		
		public function destroy():void
		{
			_structuralDataListenerUtil.destroy();
			
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}	
	}
}