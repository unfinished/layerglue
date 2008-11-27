package com.layerglue.flex3.base.views.showHide
{
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.ITransitionableNavigableView;
	
	import flash.display.DisplayObjectContainer;
	
	[Bindable]
	public class ShowHideBoxExt extends ShowHideBox implements ITransitionableNavigableView
	{
		
		public function ShowHideBoxExt()
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
			super.destroy();
		}

	}
}