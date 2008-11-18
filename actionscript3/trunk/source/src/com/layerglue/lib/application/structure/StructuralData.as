package com.layerglue.lib.application.structure
{
	import com.layerglue.lib.application.events.StructuralDataEvent;
	import com.layerglue.lib.base.collections.ICollection;
	
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	[Event(name="selectionChange", type="com.layerglue.lib.application.events.StructuralDataEvent")]
	[Event(name="childSelectionChange", type="com.layerglue.lib.application.events.StructuralDataEvent")]
	// TODO: dispatch children collection change event (when contents of children change)
	
	[DefaultProperty("children")]
	
	[Bindable]
	public class StructuralData extends EventDispatcher implements IStructuralData
	{
		public function StructuralData(id:String=null)
		{
			super();
			
			this.id = id;
			_selectedChildIndex = -1;
		}
		
		private var _id:String;

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
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
		
		private var _children:ICollection;
		
		public function get children():ICollection
		{
			return _children;
		}

		public function set children(value:ICollection):void
		{
			_children = value;
			
			// Children added through the ArrayCollection constructor never fire COLLECTION_CHANGE events,
			// so we need to force parenting here:
			setChildParenting(children);
			
			// TODO: Move this event and handler out into FlexCollection because CollectionEvent is reliant on Flex
			_children.addEventListener(CollectionEvent.COLLECTION_CHANGE, childrenChangeHandler, false, 0, true);
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
			return children ? getChildById(defaultChildId) as IStructuralData : null;
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
		
		[Bindable(event="selectionChange")]
		public function get selected():Boolean
		{
			return isRoot() || parent.selectedChild == this;
		}
		
		public function set selected(value:Boolean):void
		{
			//First check that the new value is different from the old one.
			if (selected != value)
			{
				if(value == true)
				{
					//If value is true, always try and set the parent's selectedChild to this instance.
					parent.selectedChild = this;
				}
				else
				{
					//Otherwise the parent will always have this instance as its selectedChild, and
					//setting the value to null is legitimate
					if(parent.selectedChild == this)
					{
						parent.selectedChild = null;
					}
					else
					{
						throw new Error("Attempted to deselect a non-selected child through parent: parent=" + parent.uri + ", child=" + uri );
					}
				}
			}
		}
		
		[Bindable(event="childSelectionChange")]
		public function get selectedChild():IStructuralData
		{
			if(children && selectedChildIndex > -1 && selectedChildIndex < children.getLength())
			{
				return children.getItemAt(selectedChildIndex) as IStructuralData;
			}
			return null;
		}
		
		public function set selectedChild(value:IStructuralData):void
		{
			if(value)
			{
				if (!children.contains(value))
				{
					throw new Error("Attemped to set selectedChild that does not exist in children: " + value + ", id: " + value.id);
				}
				
				selectedChildIndex = children.getItemIndex(value);
			}
			else
			{
				selectedChildIndex = -1;
			}
		}
		
		protected var _selectedChildIndex:int;
		
		[Bindable(event="childSelectionChange")]
		public function get selectedChildIndex():int
		{
			return _selectedChildIndex;
		}
		
		public function set selectedChildIndex(value:int):void
		{
			//TODO Look at splitting this out into a separate method that will allow forced event
			//dispatching regardless of whether anything has changed
			if(selectedChildIndex != value)
			{
				if (value < -1 || value > children.getLength()-1)
				{
					throw new Error("selectedChildIndex value out of range [length: " + length + ", index: " + value + "]");
				}
				
				if(selectedChild)
				{
					//Dispatching a change through the old selected item
					selectedChild.dispatchEvent(new StructuralDataEvent(StructuralDataEvent.SELECTION_CHANGE));
				}
				
				_selectedChildIndex = (isNaN(value)) ? -1 : value;
				
				//Before dispatching an event through the selectedChild, make sure that one exists,
				//as the selectedIndex could have been set to -1.
				if(selectedChild)
				{
					//Dispatching a change through the new selected item
					selectedChild.dispatchEvent(new StructuralDataEvent(StructuralDataEvent.SELECTION_CHANGE));
				}
				
				dispatchEvent(new StructuralDataEvent(StructuralDataEvent.CHILD_SELECTION_CHANGE));
			}
		}
		
		public function isRoot():Boolean
		{
			return !parent;
		}
		
		//TODO Make this a lazy setter, so that first time depth is requested a queery is made but
		//this should set a private _root value so the next time, no querying needs to be done.
		public function get depth():uint
		{
			return isRoot() ? 0 : parent.depth + 1;
		}
		
		private var _mapId:String;
		// TODO: property is ambiguous
		// it supposed to add further controller->view mapping solutions
		public function get mapId():String
		{
			return _mapId;
		}
		
		public function set mapId(value:String):void
		{
			_mapId = value;
		}
		
		private var _branchOnly:Boolean
		// TODO: property is ambiguous
		// it is supposed to enforce the default child
		public function get branchOnly():Boolean
		{
			return _branchOnly;
		}
		
		public function set branchOnly(value:Boolean):void
		{
			_branchOnly = value;
		}
		
		public function getChildById(id:String):IStructuralData
		{
			var item:IStructuralData;
			for each(item in children)
			{
				if(item.id == id)
				{
					return item;
				}
			}
			return null;
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
		
		public function getChildAt(index:int):IStructuralData
		{
			if(children)
			{
				return children.getItemAt(index) as IStructuralData;
			}
			return null;
		}
		
		// newChildren is untyped because the children setter sends through an instance of ICollection
		// whereas the childrenChangeHandler sends through an instance of Array
		protected function setChildParenting(newChildren:*):void
		{
			var child:IStructuralData;
			for each (child in newChildren)
			{
				child.parent = this;
			}
		}
		
		// TODO: Move the event.kind switch out into FlexCollection when we can be
		// bothered to get the whole thing working in Flash
		protected function childrenChangeHandler(event:CollectionEvent):void
		{
			switch (event.kind)
			{
				case CollectionEventKind.ADD:
				{
					setChildParenting(event.items);
					break;
				}
				case CollectionEventKind.REMOVE:
				{
					var child:IStructuralData;
					for each (child in event.items)
					{
						child.parent = null;
					}
					break;
				}
			}
		}
		
	}
}