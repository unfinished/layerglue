package com.layerglue.lib.application.views.extensions
{
	import com.layerglue.flex3.base.views.showHide.ShowHideBox;
	import com.layerglue.lib.base.events.SelectionEvent;
	import com.layerglue.lib.application.proxies.StructuralDataListenerUtil;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.IView;
	
	import flash.display.DisplayObjectContainer;
	
	public class ShowHideBoxExt extends ShowHideBox implements IView
	{
		
		protected var _structualDataListenerUtil:StructuralDataListenerUtil;
		
		public function ShowHideBoxExt()
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
			show();
		}
		
		public function startTransitionOut():void
		{
			hide();
		}
		
		public function stopTransition():void
		{
			_showHideTransitionUtil.stopCurrentEffect();
		}
		
		override public function destroy():void
		{
			_structualDataListenerUtil.destroy();
			super.destroy();
		}

	}
}