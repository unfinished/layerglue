package com.layerglue.flex3.base.views
{
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.INavigableView;
	import com.layerglue.lib.base.events.DestroyEvent;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.containers.Canvas;

	public class NavigableCanvas extends Canvas implements INavigableView
	{
		public function NavigableCanvas()
		{
			super();
		}
		
		private var _structuralData:IStructuralData;
		
		[Bindable]
		public function get structuralData():IStructuralData
		{
			return _structuralData;
		}

		public function set structuralData(value:IStructuralData):void
		{
			_structuralData = value;
			invalidateProperties();
		}
		
		private var _childViewContainer:DisplayObjectContainer;
		
		[Bindable]
		public function get childViewContainer():DisplayObjectContainer
		{
			return _childViewContainer;
		}
		
		public function set childViewContainer(value:DisplayObjectContainer):void
		{
			_childViewContainer = value;
		}
		
		public function destroy():void
		{
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}
	}
}