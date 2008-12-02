package com.layerglue.lib.application.structure
{
	import com.layerglue.lib.application.events.CollectionEvent;
	import com.layerglue.lib.application.events.CollectionEventKind;
	import com.layerglue.lib.application.events.StructuralDataEvent;
	import com.layerglue.lib.base.collections.ICollection;
	
	import flash.events.EventDispatcher;
	
	[Event(name="selectionChange", type="com.layerglue.lib.application.events.StructuralDataEvent")]
	[Event(name="childSelectionChange", type="com.layerglue.lib.application.events.StructuralDataEvent")]
	// TODO: dispatch children collection change event (when contents of children change)
	
	[DefaultProperty("children")]
	
	[Bindable]
	/**
	 * At it's simplest implementation StructuralData represents a piece of model data.
	 * In the LayerGlue framework it is considered the 'model' part of the Presentation Model pattern.
	 * It is responsible for being a single navigable point in the application. This means it usually
	 * has a URI node, which is a portion of the browsers address URL that relates to it.
	 * In most applications StructuralData will be used to create a hierarchy of 'presentation
	 * models', which map directly to views. The navigation system consists of an identical hierarchy
	 * of controllers, which create and destroy views based on what parts of the structural data
	 * hierarchy are selected.
	 *
	 * StructuralData is usually subclassed to become 'presentation models' for each navigable
	 * part of your application. 
	 *
	 * Instances of StructuralData (and subclasses) can be passed to the navigation system in order
	 * to make the system navigate. See NavigationManager for more information.
	 *
	 * At any point during the running of an application a 'strand' of the Structural data hierarchy
	 * is selected, which identifies the current location. See NavigationManager for more information.
	 *
	 * Children is an array containing instances of StructuralData that are hierarchically children of
	 * this one. In traditional Presentation Model architecture StructuralData is considered the
	 * 'model' and it's arranged in a hierachy that is reflected in the views.
	 * Each child represents a navigable location that's one level deeper than it's parent, much
	 * like the 'page' paridigm in HTML website design. The LayerGlue navigation system uses
	 * StructuralData as a 'framework' to traverse, showing and hiding views as it goes.
	 */
	public class StructuralData extends EventDispatcher implements IStructuralData
	{
		/**
		 * Creates an instance of StructuralData. This is usually done by the XMLDeserializer,
		 * which will create a complex structural hierarchy and ensure all properties are populated.
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
		 * A string representing the URI node of this StructuralData. It is used to create a chain of URI nodes
		 * that represent a browser navigable location.
		 * 
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
		 * For example, imagine a 4-level hierarchy of StructuralData's with the uriNodes 'home', 'gallery',
		 * 'artist' and 'image', if you queried the 3rd deep StructuralData for it's uri it would
		 * return "/home/gallery/artist/"
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
		 * 'model' and it's arranged in a hierachy that is reflected in the views.
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
			validateNewChildren(children);
			
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
		 * forced down a level to the <code>defaultChild</code> with the matching <code>id</code>.
		 * 
		 * --EXAMPLE HERE--
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
		 * The instance of StructuralData immediately one place level in the hierarchy.
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
		 * A Boolean that determines whether the instance StructuralData is considered 'selected' in
		 * the structural hierarchy. A 'selected' StructuralData means that it's either the current
		 * end-point of the navigation, or part of the hierarchical chain that leads down to the point.
		 * 
		 * If set to <code>true</code> the parent's corresponding <code>selectedChild</code> and
		 * <code>selectedChildIndex</code> will be set too. It won't traverse the chain further upwards
		 * than that.
		 * 
		 * Selection is usually managed by the NavigationManager and need rarely be set manually.
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
		 * The child that's considered 'selected' by the navigation system.
		 * 
		 * @see selected
		 * @see selectedChildIndex
		 */
		public function get selectedChild():IStructuralData
		{
			if(children && selectedChildIndex > -1 && selectedChildIndex < children.getLength())
			{
				// TODO: error check if child is actually in children
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
		 * The index of the selected child in the children collection.
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
					throw new Error("selectedChildIndex value out of range [length: " + children.getLength() + ", index: " + value + "]");
				}
				
				// Store the old selectedChild so we can dispatch an event from it, then anything listening
				// will know it's selection status has changed
				var oldSelectedChild:IStructuralData = selectedChild;
				
				// Update the new child index.
				// NOTE: 'selected' and 'selectedChild' run off selectedChildIndex
				_selectedChildIndex = (isNaN(value)) ? -1 : value;
				
				if(oldSelectedChild)
				{
					//Dispatching a change through the old selected child
					oldSelectedChild.dispatchEvent(new StructuralDataEvent(StructuralDataEvent.SELECTION_CHANGE));
				}
				
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
		 * (Note: An instance of StructuralData is considered root if it has no parent. Children
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
		
		protected var _structuralDataToControllerMapId:String;
		/**
		 * This can be used as an alternative to Class-to-Class reference mapping. It is useful
		 * for creating exceptions to mapping rules, e.g. the structural data class 'Artist' is
		 * usually mapped to 'ArtistController', but in one specific instance you'd like to map
		 * it to 'SpecialArtistController'. If you add a <code>structuralDataToControllerMapId</code>
		 * it will be used as a lookup in preference to Class reference mappings.
		 * 
		 * @see controllerToViewMapId
		 */
		public function get structuralDataToControllerMapId():String
		{
			return _structuralDataToControllerMapId;
		}
		
		public function set structuralDataToControllerMapId(value:String):void
		{
			_structuralDataToControllerMapId = value;
		}
		
		protected var _controllerToViewMapId:String;
		/**
		 * This can be used as an alternative to Class-to-Class reference mapping. It is useful
		 * for creating exceptions to mapping rules, e.g. the controller class 'ArtistController' is
		 * usually mapped to 'ArtistView', but in one specific instance you'd like to map
		 * it to 'SpecialArtistView'. If you add a <code>controllerToViewMapId</code>
		 * it will be used as a lookup in preference to Class reference mappings.
		 * 
		 * @see controllerToViewMapId
		 */
		public function get controllerToViewMapId():String
		{
			return _controllerToViewMapId;
		}
		
		public function set controllerToViewMapId(value:String):void
		{
			_controllerToViewMapId = value;
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
		
		// This ensures that whenever a child is added to the children collection it's parent property is set.
		// newChildren parameter is untyped because the children setter sends through an instance
		// of ICollection whereas the childrenChangeHandler sends through an instance of Array
		protected function validateNewChildren(newChildren:*):void
		{
			var child:IStructuralData;
			// If you get a Type Coercion failed error here it means one of your children aren't IStructuralData
			for each (child in newChildren)
			{
				child.parent = this;
			}
		}
		
		// TODO: Check duplicate id's or uri's when each child is added
		// TODO: Check that child is valid instance of StructuralData?
		protected function childrenChangeHandler(event:CollectionEvent):void
		{
			switch (event.kind)
			{
				case CollectionEventKind.ADD:
				{
					validateNewChildren(event.items);
					break;
				}
				case CollectionEventKind.REMOVE:
				{
					// TODO: update any selected/selectedChild properties if the selectedChild was removed
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