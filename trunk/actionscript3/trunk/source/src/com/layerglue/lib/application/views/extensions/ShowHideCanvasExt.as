package com.layerglue.lib.application.views.extensions
{
	import com.layerglue.lib.base.events.DestroyEvent;
	import com.layerglue.lib.base.events.SelectionEvent;
	import com.layerglue.lib.base.views.flex.showHide.ShowHideCanvas;
	import com.layerglue.lib.application.proxies.StructuralDataListenerUtil;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.IView;
	
	import flash.display.DisplayObjectContainer;
	
	public class ShowHideCanvasExt extends ShowHideCanvas implements IView
	{
		
		protected var _structualDataListenerUtil:StructuralDataListenerUtil;
		
		public function ShowHideCanvasExt()
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
			trace("############### ShowHideCanvasExt.startTransitionIn()");
			show();
		}
		
		public function startTransitionOut():void
		{
			trace("############### ShowHideCanvasExt.startTransitionOut()");
			hide();
		}
		
		public function stopTransition():void
		{
			_showHideTransitionUtil.stopCurrentEffect();
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			_structualDataListenerUtil.destroy();
			
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}

	}
}