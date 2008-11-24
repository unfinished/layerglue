package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.navigation.NavigationManager;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.structure.IStructuralDataListener;
	import com.layerglue.lib.application.views.IView;
	import com.layerglue.lib.base.events.DestroyEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;

	public class AbstractController extends EventDispatcher implements IController
	{
		
		public function AbstractController()
		{
			super();
			
			_children = new Array();
		}
		
		public function get navigationManager():NavigationManager
		{
			return NavigationManager.getInstance();
		}
		
		public function isRoot():Boolean
		{
			return !parent;
		}
		
		public function get root():IController
		{
			return isRoot() ? this as IController : parent.root;
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
		
		private var _viewParent:DisplayObjectContainer;
		// Unused??
		public function get viewParent():DisplayObjectContainer
		{
			return _viewParent ? _viewParent : (parent ? parent.childViewContainer : null);
		}
		
		public function set viewParent(v:DisplayObjectContainer):void
		{
			_viewParent = v;
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
		
		private var _parent:IController;

		public function get parent():IController
		{
			return _parent;
		}

		public function set parent(v:IController):void
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
		
		
		public function get selectedChild():IController
		{
			for each(var child:IController in children)
			{
				if(child.structuralData.selected)
				{
					return child;
				}
			}
			
			return null;
		}
		
		public function get deepestSelectedChild():IController
		{
			
			if(selectedChild)
			{
				if(selectedChild.selectedChild)
				{
					return selectedChild.deepestSelectedChild;
				}
				
				return selectedChild;
			}
			else
			{
				if(structuralData.selected)
				{
					return this;
				}
			}
			
			return null;
		}
			
		public function destroyChildren():void
		{
			var c:IController;
			for (var i:int=children.length ; i>-1 ; i--)
			{
				(children[i] as IController).destroy();
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
		
		public function createView(shouldAdd:Boolean=false):IView
		{
			if(!viewClassReference)
			{
				throw new Error("Tried to create a view from a controller when no controller-to-view mapping was specified: " + this);
			}
			
			var viewInstance:IView = new viewClassReference();
			(viewInstance as IStructuralDataListener).structuralData = structuralData;
			
			if(shouldAdd)
			{
				viewParent.addChild(view as DisplayObject);
			}
			
			return viewInstance;
		}
		
		/*
		public function createView(viewParent:IView, controllerToViewClassMap:HashMap=null):void
		{
			var map:HashMap = controllerToViewClassMap ? controllerToViewClassMap : (this.controllerToViewClassMap ? this.controllerToViewClassMap : ApplicationController.getInstance().controllerToViewClassMap)
			
			if(!map){
				throw new Error("No controllerToViewClassMap was supplied (either as a persistent class variable or passed directly into this method)");
			}
			
			var viewClassRef:Class = map.get(ReflectionUtils.getClassReference(this));
			
			if(!viewClassRef){
				throw new Error("No view class in map :" + map + " mapped to this controller: " + this);	
			}
			
			view = new viewClassRef();
			(viewParent as DisplayObjectContainer).addChild(view as DisplayObject);
			//trace("creating view: " + view + ", view.dataProvider: " + view.dataProvider);
			
			createChildViews();
		}
		
		
		private function createChildViews():void
		{
			var c:IController;
			for each(c in children)
			{
				c.createView(view);
			}
		}
		*/
		
		public function startTransitionIn():void
		{
		}
		
		public function startTransitionOut():void
		{
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