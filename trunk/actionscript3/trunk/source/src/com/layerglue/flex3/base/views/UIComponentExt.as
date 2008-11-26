package com.layerglue.flex3.base.views
{
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.ITransitionableNavigableView;
	import com.layerglue.lib.base.events.DestroyEvent;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.core.UIComponent;

	public class UIComponentExt extends UIComponent implements ITransitionableNavigableView
	{
		
		public function UIComponentExt()
		{
			super();
		}		
		
		[Bindable(event="structuralDataChange")]
		public function get structuralData():IStructuralData
		{
			return _structuralDataListenerUtil.structuralData;
		}

		public function set structuralData(value:IStructuralData):void
		{
			_structuralDataListenerUtil.structuralData = value;
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
			_structuralDataListenerUtil.destroy();
			
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}
	}
}