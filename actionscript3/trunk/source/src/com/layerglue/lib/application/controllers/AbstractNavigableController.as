package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.LayerGlueLocator;
	import com.layerglue.lib.application.navigation.NavigationManager;
	import com.layerglue.lib.application.navigation.NavigationPacket;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.structure.IStructuralDataListener;
	import com.layerglue.lib.application.views.IView;
	import com.layerglue.lib.base.events.DestroyEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;

	/**
	 * The abstract base class for all Navigable controllers.
	 */
	public class AbstractNavigableController extends EventDispatcher implements INavigableController
	{	
		public function AbstractNavigableController()
		{
			super();
			
			_children = new Array();
		}
		
		public function navigate():void
		{
			structuralData.selected = true;
			
			startTransitionIn();
		}
		
		public function startTransitionIn():void
		{
			//This will be asynchronous in subclasses
			throw new Error("AbstractNavigableController: startTransitionIn() must be overriden in subclasses");
		}
		
		public function startTransitionOut():void
		{
			//trace("AbstractNavigableController.startTransitionOut: " + structuralData.uri + " - " + this);
			throw new Error("AbstractNavigableController: startTransitionOut() must be overriden in subclasses");
		}
		
		public function unnavigateToCommonNode():void
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
		
		protected function tryShallowerUnnavigation():void
		{
			structuralData.selected = false;
			(parent as INavigableController).unnavigateToCommonNode();
		}
		
		protected function tryDeeperNavigation():void
		{
			var p:NavigationPacket = navigationManager.currentAddressPacket;
			
			var c:INavigableController = p.getControllerAtDepth(depth+1);
			
			if(c)
			{
				c.navigate();
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
		/* 
		public function get root():INavigableController
		{
			return isRoot() ? this as INavigableController : parent.root;
		} */
		
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
		
		 
		private var _view:IView;

		public function get view():IView
		{
			return _view;
		}
		
		public function set view(value:IView):void
		{
			var oldValue:IView = _view;
			
			_view = value;
			setViewDataProvider();
			viewPropertyChangeHandler(oldValue, value);
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
		
		public function destroyChildren():void
		{
			var c:INavigableController;
			for (var i:int=children.length ; i>-1 ; i--)
			{
				(children[i] as INavigableController).destroy();
				children.splice(i, 1);
			}
		}
		
		public function viewPropertyChangeHandler(oldValue:IView, newValue:IView):void
		{
			//Handle changes in view here
		}
		
		public function destroy():void
		{
			destroyChildren();
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}
		
		public function createView(shouldAdd:Boolean=false):void
		{
			var viewInstance:IView = new viewClassReference();
			(viewInstance as IStructuralDataListener).structuralData = structuralData;
			
			view = viewInstance;
			
			if(shouldAdd)
			{
				addView();
			}
		}
		
		public function addView():void
		{
			if(!viewContainer)
			{
				throw new Error("Attempted to add a view to a non-existent viewContainer.");
			}
			viewContainer.addChild(view as DisplayObject);
		}
		
		public function destroyView():void
		{
			if(view)
			{
				view.destroy();
				view = null;
			}
		}
		
	}
}