package com.layerglue.lib.framework.structure
{
	import com.layerglue.lib.base.collections.SelectableBusinessValueObjectCollection;
	import com.layerglue.lib.base.core.ISelectable;
	import com.layerglue.lib.base.events.EventListener;
	import com.layerglue.lib.base.events.SelectionEvent;
	import com.layerglue.lib.base.models.vos.BusinessValueObject;
	import com.layerglue.lib.framework.events.StructuralDataEvent;
	
	[Event(name="subselectionChange", type="com.layerglue.lib.base.events.SelectionEvent")]
	[Event(name="selectionStatusChange", type="com.layerglue.lib.base.events.SelectionEvent")]
	[Event(name="childrenChange", type="com.layerglue.lib.base.events.StructuralDataEvent")]
	
	[Bindable]
	public class StructuralData extends BusinessValueObject implements IStructuralData, ISelectable
	{
		public function StructuralData(id:String=null)
		{
			super(id);
		}
		
		private var _uriNode:String;
		
		public function get uriNode():String
		{
			return _uriNode;
		}

		public function set uriNode(v:String):void
		{
			_uriNode = v;
		}
		
		public function get uri():String
		{
			return isRoot() ? "/" : (parent.uri + uriNode + "/");
		}
		
		private var _title:String;

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}
		
		private var _children:SelectableBusinessValueObjectCollection;
		
		[Bindable(event="childrenChange")]
		public function get children():SelectableBusinessValueObjectCollection
		{
			return _children;
		}

		public function set children(value:SelectableBusinessValueObjectCollection):void
		{
			_children = value;
			
			//Make sure to stop listening to the previous value
			removeChildrenSubselectionChangeListener();
			
			//If children exists listen for changes
			if(_children)
			{
				_childrenSubselectionChangeListener = new EventListener(children, SelectionEvent.SUBSELECTION_CHANGE, childrenSubselectionChangeHandler);
			}
			
			dispatchEvent(new StructuralDataEvent(StructuralDataEvent.CHILDREN_CHANGE));
		}
		
		private var _childrenSubselectionChangeListener:EventListener;
		
		private function childrenSubselectionChangeHandler(event:SelectionEvent):void
		{
			dispatchEvent(new SelectionEvent(SelectionEvent.SUBSELECTION_CHANGE));
		}
		
		private function removeChildrenSubselectionChangeListener():void
		{
			if(_childrenSubselectionChangeListener)
			{
				_childrenSubselectionChangeListener.destroy();
				_childrenSubselectionChangeListener = null;
			}
		}
		
		private var _defaultChildId:String;
		
		public function get defaultChildId():String
		{
			return _defaultChildId;
		}

		public function set defaultChildId(value:String):void
		{
			_defaultChildId = value;
		}
				
		public function get defaultChild():IStructuralData
		{
			return children ? children.getItemById(defaultChildId) as IStructuralData : null;
		}
		
		private var _parent:IStructuralData;

		public function get parent():IStructuralData
		{
			return _parent;
		}
		
		public function set parent(v:IStructuralData):void
		{
			_parent = v;
		}
		
		private var _selected:Boolean;

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			if(_selected != value)
			{
				_selected = value;
				dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_STATUS_CHANGE));
			}
		}
		
		[Bindable(event="subselectionChange")]
		public function get selectedChild():IStructuralData
		{
			return children ? children.selectedItem as IStructuralData : null;
		}
		
		public function set selectedChild(value:IStructuralData):void
		{
			children.selectedItem = value;
			//TODO look at how whether subselectionChange is dispatched from this class when children collection changes its subselection
		}
		
		public function isRoot():Boolean
		{
			return !parent;
		}
		
		public function get depth():uint
		{
			return isRoot() ? 0 : parent.depth + 1;
		}
		
		private var _deserialized:Boolean;
		
		public function get deserialized():Boolean
		{
			return _deserialized;
		}
		
		public function set deserialized(value:Boolean):void
		{
			_deserialized = value;
		}
		
		private var _mapId:String;
		
		public function get mapId():String
		{
			return _mapId;
		}
		
		public function set mapId(value:String):void
		{
			_mapId = value;
		}
		
		private var _branchOnly:Boolean
		
		public function get branchOnly():Boolean
		{
			return _branchOnly;
		}
		
		public function set branchOnly(value:Boolean):void
		{
			_branchOnly = value;
		}
		
		public function getChildByUriNode(nodeName:String):IStructuralData
		{
			var child:IStructuralData;
			for each(child in children)
			{
				if(child.uriNode == nodeName)
				{
					return child;
				}
			}
			
			return null;
		}
		
		//TODO check this isnt too naughty
		public function deselect():void
		{
			parent.children.deselect();
		}
	}
}