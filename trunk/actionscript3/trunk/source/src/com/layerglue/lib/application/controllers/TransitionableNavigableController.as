package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.events.FrameworkTransitionEvent;
	import com.layerglue.lib.application.views.ITransitionableNavigableView;
	import com.layerglue.lib.base.collections.EventListenerCollection;
	
	import flash.display.DisplayObject;
	
	public class TransitionableNavigableController extends NavigableController
	{
		protected var _viewTransitionListenerCollection:EventListenerCollection;
		
		public function TransitionableNavigableController()
		{
			super();
		}
		
		override public function navigate():void
		{
			trace("TransitionableNavigableController.navigate: " + this + " id=" + structuralData.id);
			structuralData.selected = true;
			
			// Simply having a view is too much of an assumption for going forwards with navigation
			// We need to inspect something like the ShowHideState to determine if the view is visible
			if (view && viewContainer.contains(view as DisplayObject))
			{
				tryDeeperNavigation();
			}
			else
			{
				if (!view)
				{
					createView();
					createViewTransitionListenerCollection();
				}
				addView();
				startTransitionIn();
			}
		}
		
		override public function unnavigate():void
		{
			trace("TransitionableNavigableController.unnavigate: " + this + " id=" + structuralData.id);
			var currentAddressPacketControllerAtOurDepth:INavigableController = navigationManager.currentAddressPacket.getControllerAtDepth(depth) 
			if(isRoot() || ( currentAddressPacketControllerAtOurDepth && structuralData == currentAddressPacketControllerAtOurDepth.structuralData))
			{
				navigationManager.unnavigationCompleteHandler(this);
			}
			else
			{
				if (view && viewContainer && viewContainer.contains(view as DisplayObject))
				{
					startTransitionOut();
				}
				else
				{
					viewTransitionOutCompleteHandler(null);
				}
			}
		}
		
		protected function startTransitionIn():void
		{
			trace("TransitionableNavigableController.startTransitionIn");
			(view as ITransitionableNavigableView).startTransitionIn();		
		}
		
		protected function startTransitionOut():void
		{
			trace("TransitionableNavigableController.startTransitionOut");
			(view as ITransitionableNavigableView).startTransitionOut();
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
			trace("TransitionableNavigableController.viewTransitionInCompleteHandler");
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
			trace("TransitionableNavigableController.viewTransitionOutCompleteHandler");
			if(view)
			{
				//removeView();
				destroyView();
			}
			
			tryShallowerUnnavigation();
		}
		
	}
}