package com.layerglue.flex3.base.views
{
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.ITransitionableNavigableView;
	import com.layerglue.lib.base.events.DestroyEvent;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.containers.Canvas;

	public class CanvasExt extends Canvas implements ITransitionableNavigableView
	{
		public function CanvasExt()
		{
			super();
		}
		
		private var _structuralData:IStructuralData;
		
		public function get structuralData():IStructuralData
		{
			return _structualData
		}

		public function set structuralData(value:IStructuralData):void
		{
			_structuralData = value;
			invalidateProperties();
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
		}
		
		public function startTransitionOut():void
		{
		}
		
		public function stopTransition():void
		{
		}
		
		public function destroy():void
		{
			if(parent)
			{
				parent.removeChild(this);
			}

			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}
	}
}