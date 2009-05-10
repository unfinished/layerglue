package com.layerglue.flex3.base.views.showHide
{
	import com.layerglue.flex3.base.views.showHide.ShowHideCanvas;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.ITransitionableNavigableView;
	import com.layerglue.lib.base.events.DestroyEvent;
	
	import flash.display.DisplayObjectContainer;
	
	public class ShowHideCanvasExt extends ShowHideCanvas implements ITransitionableNavigableView
	{
	
		public function ShowHideCanvasExt()
		{
			super();
		}
		
		private var _structuralData:IStructuralData;
		
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
			
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}

	}
}