package com.layerglue.lib.framework.views.extensions
{
	import com.layerglue.lib.base.events.DestroyEvent;
	import com.layerglue.lib.base.events.SelectionEvent;
	import com.layerglue.lib.framework.proxies.StructuralDataListenerUtil;
	import com.layerglue.lib.framework.structure.IStructuralData;
	import com.layerglue.lib.framework.views.IView;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.containers.Canvas;

	public class CanvasExt extends Canvas implements IView
	{
		protected var _structualDataListenerUtil:StructuralDataListenerUtil;
		
		public function CanvasExt()
		{
			super();
			
			_structualDataListenerUtil = new StructuralDataListenerUtil(this);
		}
		
		[Bindable(event="structuralDataChange")]
		public function get structuralData():IStructuralData
		{
			return _structualDataListenerUtil.structuralData;
		}

		public function set structuralData(value:IStructuralData):void
		{
			_structualDataListenerUtil.structuralData = value;
		}
		
		public function structuralDataPropertyChangeHandler(oldStructuralData:IStructuralData, newStructuralData:IStructuralData):void
		{
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
		
		public function structuralDataSubselectionChangeHandler(event:SelectionEvent):void
		{
		}
		
		public function structuralDataSelectionStatusChangeHandler(event:SelectionEvent):void
		{
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
			
			_structualDataListenerUtil.destroy();
			
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}
	}
}