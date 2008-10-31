package com.layerglue.lib.framework.views.extensions
{
	import com.layerglue.lib.base.events.DestroyEvent;
	import com.layerglue.lib.base.events.SelectionEvent;
	import com.layerglue.lib.framework.proxies.StructuralDataListenerUtil;
	import com.layerglue.lib.framework.structure.IStructuralData;
	import com.layerglue.lib.framework.views.IView;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.core.UIComponent;

	public class UIComponentExt extends UIComponent implements IView
	{
		protected var _structuralDataListenerUtil:StructuralDataListenerUtil;
		
		public function UIComponentExt()
		{
			super();
			
			_structuralDataListenerUtil = new StructuralDataListenerUtil(this);
		}		
		
		[Bindable(event="structuralDataChange")]
		public function get structuralData():IStructuralData
		{
			return _structuralDataListenerUtil.structuralData;
		}

		public function set structuralData(value:IStructuralData):void
		{
			_structuralDataListenerUtil.structuralData = value;
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
			invalidateProperties();
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
			_structuralDataListenerUtil.destroy();
			
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}
	}
}