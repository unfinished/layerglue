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
	/**
	 * At it's simplest implementation StructuralData represents a piece of model data.
	 * It is commonly considered the 'model' in the Presentation Model pattern.
	 * However it can also be used in conjunction with other parts of the LayerGlue framework
	 * to provide the following featurs:
	 * <ul>
	 * <li>Is a navigable location within the application</li>
	 * <li>Has a URI that forms part of the deep-linkable address</li>
	 * </ul>
	 * In most applications StructuralData will be used to create a hierarchy of 'presentation
	 * models', which map directly to views. The navigation system (controllers) traverses
	 * the structural data hierarchy, revealing and hiding views as it goes.
	 * --EXPLANATION OF DESERIALIZER--
	 * --USUALLY SUBCLASSED--
	 * --EXPLANATION OF SELECTED STRANDS--
	 * --INSTANCES PASSED TO NAVIGATION SYSTEM AS LOCATIONS--
	 */
	public class StructuralData extends EventDispatcher implements IStructuralData
	{
		/**
		 * Creates an instance of StructuralData. This is usually done by the XMLDeserializer,
		 * which will create a complex structural hierarchy and ensuring all properties are populated.
		 */
		public function StructuralData(id:String=null)
		{
			super();
			
			this.id = id;
			_selectedChildIndex = -1;
		}
		
		protected var _id:String;
		/**
		 * A reference to the StructuralData. This should be unique for each level of the structural
		 * hierarchy.
		 * @see defaultChildId
		 */
		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}
		
		protected var _uriNode:String;
		/**
		 * A string representing the URI of this StructuralData. It is used to create a chain of URI nodes
		 * that represent a browser navigable location within the application.
		 * --EXAMPLE HERE--
		 * @see uri
		 */
		public function get uriNode():String
		{
			return _uriNode;
		}

		public function set uriNode(v:String):void
		{
			_uriNode = v;
		}
		/**
		 * Returns the chain of URI nodes that make up the navigable location of this StructuralData.
		 * In most applications this is a concatenation of all parent nodes starting from the root.
		 * --EXAMPLE HERE--
		 * @see uriNode
		 */
		public function get uri():String
		{
			return isRoot() ? "/" : (parent.uri + uriNode + "/");
		}
		
		protected var _title:String;
		/**
		 * A string representing the title of a StrucrualData location. This is commonly used in
		 * browser integration, for example page titling, or for generating other navigable elements,
		 * such as crumb trails.
		 */
		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}
		
		protected var _children:ICollection;
		/**
		 * An array containing instances of StructuralData that are hierarchically children of
		 * this one. In traditional Presentation Model architecture StructuralData is considered the
		 * 'model' and it's arranged in a hierachy that reflects the views.
		 * Each child represents a navigable location that's one level deeper than it's parent, much
		 * like the 'page' paridigm in HTML website design. The LayerGlue navigation system uses
		 * StructuralData as a 'framework' to traverse, showing and hiding views as it goes.
		 * 
		 * @see selectedChild
		 * @see defaultChild
		 */
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
				
		protected var _defaultChildId:String;
		/**
		 * A string representing the <code>id</code> of one of the children.
		 * This is used to determine which child should be deferred to when navigating to this piece
		 * of StructuralData. Sometimes a 'location' (in Presentation Model this is considered both the
		 * model and the view) may not have anything in it - it may simply be a shell or container
		 * to help display content nested deeper in the hierarchy. In this instance navigation will be
		 * forced down a level to the <code>defaultChild</code>.
		 * 
		 * --EXAMPLE HERE--
		 * 
		 * Child with the id must be present for <code>defaultChild</code> to return a valid reference.
		 * 
		 * @see defaultChild
		 */
		public function get defaultChildId():String
		{
			return _defaultChildId;
		}

		public function set defaultChildId(value:String):void
		{
			_defaultChildId = value;
		}
		
		/**
		 * The child deferred to in cases of navigation to this StructuralData. This is commonly used
		 * when a 'location' only serves as a shell or container for content nested deeper.
		 * 
		 * @see defaultChildId
		 */
		public function get defaultChild():IStructuralData
		{
			return children ? getChildById(defaultChildId) as IStructuralData : null;
		}
		
		protected var _parent:IStructuralData;
		/**
		 * Parent is always the instance of StructuralData immediately one palce higher in the hierarchy.
		 * The top-most instance of StructuralData (i.e. the root) has no parent and will return null.
		 * This property is automatically set whenever you add an instance of StructuralData to the
		 * children array.
		 */
		public function get parent():IStructuralData
		{
			return _parent;
		}
		
		public function set parent(v:IStructuralData):void
		{
			_parent = v;
		}
		
		[Bindable(event="selectionChange")]
		/**
		 * Whether this instance of StructuralData is selected.
		 * --WRITE MORE OF AN EXPLANATION--
		 * 
		 * @see selectedChild
		 * @see selectedChildIndex
		 */
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
		/**
		 * The instance of StructuralData held within the children collection that's considered
		 * selected by the navigation system.
		 * --WRITE MORE OF AN EXPLANATION--
		 * 
		 * @see selected
		 * @see selectedChildIndex
		 */
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
		/**
		 * The collection index of the selected child.
		 * --WRITE MORE OF AN EXPLANATION--
		 * 
		 * @see selected
		 * @see selectedChild
		 */
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
		
		/**
		 * Whether this instance of StructuralData is considered the top-most 'root'.
		 * (Note: An instance of StructuralData is considered root if it has not parent. Children
		 * always have parents and therefore cannot be roots.)
		 */
		public function isRoot():Boolean
		{
			return !parent;
		}
		
		/**
		 * An integer representing the depth of this instance of StructuralData in the hierachy.
		 */
		//TODO Make this a lazy setter, so that first time depth is requested a queery is made but
		//this should set a private _root value so the next time, no querying needs to be done.
		public function get depth():uint
		{
			return isRoot() ? 0 : parent.depth + 1;
		}
		
		protected var _mapId:String;
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
		
		protected var _branchOnly:Boolean
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
		
		/**
		 * Returns a StructuralData child based on id. Returns null if child with id doesn't exist.
		 * 
		 * @param id String representing the <code>id</code>
		 * @see id
		 * @see children
		 */
		// TODO: Not sure if this is getting event updates when children change
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
		
		/**
		 * Returns a StructuralData child based on uriNode. Returns null if child with uriNode doesn't exist.
		 * 
		 * @param uriNode String representing the <code>uriNode</code>
		 * @see uriNode
		 * @see uri
		 */
		// TODO: Not sure if this is getting event updates when children change
		public function getChildByUriNode(uriNode:String):IStructuralData
		{
			var child:IStructuralData;
			for each(child in children)
			{
				if(child.uriNode == uriNode)
				{
					return child;
				}
			}
			return null;
		}
		
		/**
		 * Returns a StructuralData child based on it's index within the children collection.
		 * This is preferable to using <code>children.getItemAt()</code> because it casts the
		 * result to IStructuralData.
		 * 
		 * @param index Number representing the index of the children collection
		 */
		// TODO: Not sure if this is getting event updates when children change
		public function getChildAt(index:int):IStructuralData
		{
			if(children)
			{
				return children.getItemAt(index) as IStructuralData;
			}
			return null;
		}
		
		// newChildren parameter is untyped because the children setter sends through an instance
		// of ICollection whereas the childrenChangeHandler sends through an instance of Array
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
					// TODO: update any selection properties if the selectedChild was removed
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