package com.client.project.structure
{
	import com.layerglue.lib.base.models.vos.BusinessValueObject;
	import com.layerglue.lib.base.utils.ArrayUtils;
	
	
	 // TODO: Most of these events can be handled by binding
	 // i.e. propertyChange and collectionChange 
	/* 
	[Event(name="subselectionChange", type="com.layerglue.lib.base.events.SelectionEvent")]
	[Event(name="selectionStatusChange", type="com.layerglue.lib.base.events.SelectionEvent")]
	[Event(name="childrenChange", type="com.layerglue.lib.base.events.StructuralDataEvent")]
	 */
	 
	[DefaultProperty("children")]
	
	[Bindable]
	// TODO: Look at BVO and what it prescribes
	public class StructuralData extends BusinessValueObject implements IStructuralData
	{
		public function StructuralData(id:String=null)
		{
			super(id);
			_selectedChildIndex = -1;
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
		
		private var _children:Array;
		
		[ArrayElementType("com.client.project.structure.IStructuralData")]
		public function get children():Array
		{
			return _children;
		}

		public function set children(value:Array):void
		{
			_children = value;
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
			}
		}
		
		public function get selectedChild():IStructuralData
		{
			// TODO: should test for valid selectedChildIndex
			return children ? children[selectedChildIndex] as IStructuralData : null;
		}
		
		public function set selectedChild(value:IStructuralData):void
		{
			if(!ArrayUtils.contains(children, value))
			{
				throw new Error("selectedChild does not exist in children: " + value + ", id: " + value.id);
			}
			
			selectedChildIndex = ArrayUtils.getIndex(children, value);
			// TODO: set selected prop on child (eg refreshSubselections());
		}
		
		protected var _selectedChildIndex:int;
		
		public function get selectedChildIndex():int
		{
			return _selectedChildIndex;
		}
		
		public function set selectedChildIndex(value:int):void
		{
			if(value > children.length-1)
			{
				throw new Error("selectedChildIndex value out of range [length: " + length + ", index: " + value + "]");
			}
			
			_selectedChildIndex = (isNaN(value)) ? -1 : value;
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
		// TODO: property is ambiguous
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
			// TODO: this may be the tricky bit
			parent.children.deselect();
		}
		
		// TODO: Should this be part of the public API?
		protected function getChildById(id:String):IStructuralData
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
	}
}