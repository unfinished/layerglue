package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.LayerGlueLocator;
	import com.layerglue.lib.application.navigation.NavigationManager;
	import com.layerglue.lib.application.navigation.NavigationPacket;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.INavigableView;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;

	/**
	 * The abstract base class for all Navigable controllers.
	 */
	public class NavigableController extends EventDispatcher implements INavigableController
	{	
		public function NavigableController()
		{
			super();
			
			_children = new Array();
		}
		
		public function navigate():void
		{
			trace("NavigableController.navigate: " + this + " id=" + structuralData.id);
			structuralData.selected = true;
			if (!view)
			{
				createView();
			}
			addView();
			tryDeeperNavigation();
		}
		
		public function unnavigate():void
		{
			trace("NavigableController.unnavigate: " + this + " id=" + structuralData.id);
			
			if(isRoot() || structuralData.uriNode == navigationManager.currentAddressPacket.getUriNodeAtDepth(depth))
			{
				navigationManager.unnavigationCompleteHandler(this);
			}
			else
			{
				// TODO: Which should be default? Should it be switchable?
				//removeView();
				destroyView();
				tryShallowerUnnavigation();
			}
		}
		
		protected function tryShallowerUnnavigation():void
		{
			structuralData.selected = false;
			(parent as INavigableController).unnavigate();
		}
		
		protected function tryDeeperNavigation():void
		{
			var p:NavigationPacket = navigationManager.currentAddressPacket;
			
			//Try to get a deeper controller from the address contained by the packet
			var deeperController:INavigableController = getChildByUriNode(p.getUriNodeAtDepth(depth+1));
			
			//Check if the address contains a reference to a deeper controller
			if(deeperController)
			{
				deeperController.navigate();
			}
			else
			{
				//Try to get a deeper controller by checking if there is a default child
				deeperController = getChildById(structuralData.defaultChildId);
				
				//Check if there is deeperController we should be navigating down to
				if(deeperController)
				{
					deeperController.navigate();
				}
				else
				{
					trace("Reached deepest navigation point: " + structuralData.uri);
				}
			}
		}
		
		protected function setStructuralDataToSelected():void
		{
			if(structuralData.parent)
			{
				structuralData.parent.selectedChild = structuralData;
			}
		}
		
		/**
		 * Searches contained children for an item with a structuralData.uriNode property matching
		 * the supplied value
		 */
		public function getChildByUriNode(nodeName:String):INavigableController
		{
			var child:INavigableController;
			for each(child in children)
			{
				if(child.structuralData.uriNode == nodeName)
				{
					return child;
				}
			}
			
			return null;
		}
		
		/**
		 * Searches contained children for an item with a structuralData.id property matching
		 * the supplied value
		 */
		public function getChildById(id:String):INavigableController
		{
			var child:INavigableController;
			for each(child in children)
			{
				if(child.structuralData.id == id)
				{
					return child;
				}
			}
			
			return null;
		}
		
		/**
		 * Returns the default child of this controller if one is specified
		 */
		public function get defaultChild():INavigableController
		{
			return structuralData.defaultChild ? getChildByUriNode(structuralData.defaultChild.uriNode) : null;
		}
		
		
		public function get navigationManager():NavigationManager
		{
			return LayerGlueLocator.getInstance().navigationManager;
		}
		
		public function isRoot():Boolean
		{
			return !parent;
		}
		
		private var _structuralData:IStructuralData;

		public function get structuralData():IStructuralData
		{
			return _structuralData;
		}
		
		public function set structuralData(value:IStructuralData):void
		{
			var oldValue:IStructuralData;
			_structuralData = value;
			setViewDataProvider();
		}
		
		private var _viewContainer:DisplayObjectContainer;
		
		/**
		 * @inheritDoc
		 */
		public function get viewContainer():DisplayObjectContainer
		{
			return _viewContainer ? _viewContainer : (parent && parent.view ? parent.view.childViewContainer : null);
		}
		
		public function set viewContainer(value:DisplayObjectContainer):void
		{
			_viewContainer = value;
		}
		
		protected var _viewClassReference:Class; 
		
		public function get viewClassReference():Class
		{
			return _viewClassReference;
		}
		
		public function set viewClassReference(value:Class):void
		{
			_viewClassReference = value;
		}
		
		 
		private var _view:INavigableView;

		public function get view():INavigableView
		{
			return _view;
		}
		
		public function set view(value:INavigableView):void
		{
			var oldValue:INavigableView = _view;
			
			_view = value;
			setViewDataProvider();
		}
		
		protected function setViewDataProvider():void
		{
			if(view && view.structuralData != structuralData)
			{
				view.structuralData = structuralData;
			}
		}
		
		private var _parent:INavigableController;

		public function get parent():INavigableController
		{
			return _parent;
		}

		public function set parent(v:INavigableController):void
		{
			_parent = v;
		}
		
		private var _children:Array;
		
		public function get children():Array
		{
			return _children;
		}

		public function set children(v:Array):void
		{
			_children = v;
		}
		
		public function get depth():uint
		{
			return isRoot() ? 0 : parent.depth + 1;
		}
		
		
		public function get selectedChild():INavigableController
		{
			for each(var child:INavigableController in children)
			{
				if(child.structuralData.selected)
				{
					return child;
				}
			}
			
			return null;
		}
		
		public function createView():void
		{
			var viewInstance:INavigableView = new viewClassReference() as INavigableView;
			if (!viewInstance)
			{
				throw new Error("Cannot create view instance from viewClassReference: " + this + " id=" + structuralData.id);
			}
			viewInstance.structuralData = structuralData;
			view = viewInstance;
			trace("NavigableController.createView: "+view);
		}
		
		protected function addView():void
		{
			if (view && viewContainer && !viewContainer.contains(view as DisplayObject))
			{
				trace("NavigableController.addView: "+view);
				viewContainer.addChild(view as DisplayObject);
			}
		}
		
		public function removeView():void
		{
			if(view && viewContainer && viewContainer.contains(view as DisplayObject))
			{
				viewContainer.removeChild(view as DisplayObject);
				trace("NavigableController.removeView: "+view);
			}
		}
		
		public function destroyView():void
		{
			if(view)
			{
				removeView();
				trace("NavigableController.destroyView: "+view);
				view.destroy();
				view.structuralData = null;
				view = null;
			}
		}
		
	}
}