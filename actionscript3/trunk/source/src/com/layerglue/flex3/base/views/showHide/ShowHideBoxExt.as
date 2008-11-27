package com.layerglue.flex3.base.views.showHide
{
	import com.layerglue.lib.application.events.FrameworkTransitionEvent;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.ITransitionableNavigableView;
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.events.ShowHideEvent;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.effects.Effect;
	import mx.effects.Fade;
	
	[Bindable]
	public class ShowHideBoxExt extends ShowHideBox implements ITransitionableNavigableView
	{
		
		private var _showHideTransitionEventListenerCollection:EventListenerCollection;
		
		public function ShowHideBoxExt()
		{
			super();
			createShowHideTransitionEventListenerCollection();
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
		
		override public function getEffectForShowing():Effect
		{
			var fade:Fade = new Fade(this);
			fade.alphaFrom = 0;
			fade.alphaTo = 1;
			fade.duration = 500;
			return fade;
		}
		
		override public function getEffectForHiding():Effect
		{
			var fade:Fade = new Fade(this);
			fade.alphaFrom = 1;
			fade.alphaTo = 0;
			fade.duration = 500;
			return fade;
		}
		
		private function createShowHideTransitionEventListenerCollection():void
		{
			_showHideTransitionEventListenerCollection = new EventListenerCollection();
			
			_showHideTransitionEventListenerCollection.createListener(this, ShowHideEvent.SHOW_START, showStartHandler);
			_showHideTransitionEventListenerCollection.createListener(this, ShowHideEvent.SHOW_STOP, showStopHandler);
			_showHideTransitionEventListenerCollection.createListener(this, ShowHideEvent.SHOW_END, showEndHandler);
			
			_showHideTransitionEventListenerCollection.createListener(this, ShowHideEvent.HIDE_START, hideStartHandler);
			_showHideTransitionEventListenerCollection.createListener(this, ShowHideEvent.HIDE_STOP, hideStopHandler);
			_showHideTransitionEventListenerCollection.createListener(this, ShowHideEvent.HIDE_END, hideEndHandler);
		}
		
		private function destroyShowHideTransitionEventListenerCollection():void
		{
			if(_showHideTransitionEventListenerCollection)
			{
				_showHideTransitionEventListenerCollection.removeAll();
				_showHideTransitionEventListenerCollection = null;
			}
		}
		
		protected function showStartHandler(event:ShowHideEvent):void
		{
			dispatchEvent(new FrameworkTransitionEvent(FrameworkTransitionEvent.TRANSITION_IN_START));
		}
		
		protected function showStopHandler(event:ShowHideEvent):void
		{
			dispatchEvent(new FrameworkTransitionEvent(FrameworkTransitionEvent.TRANSITION_IN_STOP));
		}
		
		protected function showEndHandler(event:ShowHideEvent):void
		{
			dispatchEvent(new FrameworkTransitionEvent(FrameworkTransitionEvent.TRANSITION_IN_COMPLETE));
		}
			
		protected function hideStartHandler(event:ShowHideEvent):void
		{
			dispatchEvent(new FrameworkTransitionEvent(FrameworkTransitionEvent.TRANSITION_OUT_START));
		}
		
		protected function hideStopHandler(event:ShowHideEvent):void
		{
			dispatchEvent(new FrameworkTransitionEvent(FrameworkTransitionEvent.TRANSITION_OUT_STOP));
		}
		
		protected function hideEndHandler(event:ShowHideEvent):void
		{
			if(parent)
			{
				dispatchEvent(new FrameworkTransitionEvent(FrameworkTransitionEvent.TRANSITION_OUT_COMPLETE));
			}
		}

	}
}