package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.events.FrameworkTransitionEvent;
	import com.layerglue.lib.base.collections.EventListenerCollection;
	
	public class TransitionableNavigableController extends AbstractNavigableController
	{
		protected var _viewTransitionListenerCollection:EventListenerCollection;
		
		public function TransitionableNavigableController()
		{
			super();
		}
		
		override public function navigate():void
		{
			structuralData.selected = true;
			
			startTransitionIn();
		}
		
		override public function unnavigateToCommonNode():void
		{
			var currentAddressPacketControllerAtOurDepth:INavigableController = navigationManager.currentAddressPacket.getControllerAtDepth(depth) 
			if(isRoot() || ( currentAddressPacketControllerAtOurDepth && structuralData == currentAddressPacketControllerAtOurDepth.structuralData))
			{
				navigationManager.unnavigationCompleteHandler(this);
			}
			else
			{
				startTransitionOut();
			}
		}
		
		public function startTransitionIn():void
		{
			if (view)
			{
				tryDeeperNavigation();
			}
			else
			{ 
				createView();
				
				view.startTransitionIn();
			}			
		}
		
		public function startTransitionOut():void
		{
			if(view)
			{
				view.startTransitionOut();
			}
			else
			{
				tryShallowerUnnavigation();
			}
		}
		
		protected function createViewTransitionListenerCollection():void
		{
			destroyViewTransitionListenerCollection();
			
			_viewTransitionListenerCollection = new EventListenerCollection();
			
			_viewTransitionListenerCollection.createListener(view, FrameworkTransitionEvent.TRANSITION_IN_START, viewTransitionInStartHandler);
			_viewTransitionListenerCollection.createListener(view, FrameworkTransitionEvent.TRANSITION_IN_STOP, viewTransitionInStopHandler);
			_viewTransitionListenerCollection.createListener(view, FrameworkTransitionEvent.TRANSITION_IN_COMPLETE, viewTransitionInCompleteHandler);
			
			_viewTransitionListenerCollection.createListener(view, FrameworkTransitionEvent.TRANSITION_OUT_START, viewTransitionOutStartHandler);
			_viewTransitionListenerCollection.createListener(view, FrameworkTransitionEvent.TRANSITION_OUT_STOP, viewTransitionOutStopHandler);
			_viewTransitionListenerCollection.createListener(view, FrameworkTransitionEvent.TRANSITION_OUT_COMPLETE, viewTransitionOutCompleteHandler);
		}
		
		protected function destroyViewTransitionListenerCollection():void
		{
			if(_viewTransitionListenerCollection)
			{
				_viewTransitionListenerCollection.removeAll();
				_viewTransitionListenerCollection = null;
			}
		}
		
		protected function viewTransitionInStartHandler(event:FrameworkTransitionEvent):void
		{
		}
		
		protected function viewTransitionInStopHandler(event:FrameworkTransitionEvent):void
		{
		}
		
		protected function viewTransitionInCompleteHandler(event:FrameworkTransitionEvent):void
		{
			tryDeeperNavigation();
		}
		
		protected function viewTransitionOutStartHandler(event:FrameworkTransitionEvent):void
		{
		}
		
		protected function viewTransitionOutStopHandler(event:FrameworkTransitionEvent):void
		{
		}
		
		protected function viewTransitionOutCompleteHandler(event:FrameworkTransitionEvent):void
		{
			if(view)
			{
				view.destroy();
				view = null;
			}
			
			tryShallowerUnnavigation();
		}
		
	}
}