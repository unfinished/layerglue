package com.layerglue.lib.base.io.xml
{
	import com.layerglue.lib.base.collections.strategies.CollectionStrategyMap;
	import com.layerglue.lib.base.utils.ArrayUtils;
	import com.layerglue.lib.base.utils.ReflectionUtils;
	import com.layerglue.lib.base.utils.XMLUtils;
	
	import flash.events.EventDispatcher;
	
	/**
	 * Deserializes XML into actionscript objects. It is typically used with
	 * a deserialization map, specifying the class each node translates to.
	 */
	public class XMLDeserializer extends EventDispatcher
	{
		namespace deserializerNamespace = "com.layerglue.lib.base.io.xml.Deserializer";
		
		public function XMLDeserializer()
		{
			super();
			
			//parentField = "parent";
			ignoreArraysWhenParenting = true;
			
			deserializeUnmappedObjects = false;
			groupSameNamedUnmappedNodes = false;
			
			anonymousObjectType = Object;
			anonymousCollectionType = Array;
			
			
			collectionStrategyMap = new CollectionStrategyMap();
		}
		
		private var _map:XMLDeserializationMap;
		
		/**
		 * An optional DeserializationMap instance, to specify explicit mappings between node names
		 * and classes
		 */
		public function get map():XMLDeserializationMap
		{
			return _map;
		}

		public function set map(v:XMLDeserializationMap):void
		{
			_map = v;
		}
		
		private var _collectionStrategyMap:CollectionStrategyMap;
		/**
		 * 
		 */
		public function get collectionStrategyMap():CollectionStrategyMap
		{
			return _collectionStrategyMap;
		}

		public function set collectionStrategyMap(v:CollectionStrategyMap):void
		{
			_collectionStrategyMap = v;
		}
		
		private var _parentField:String;
		
		/**
		 * The name of the parentField in the hierarchy of classes. This value defaults to "parent".
		 */
		public function get parentField():String
		{
			return _parentField;
		}

		public function set parentField(v:String):void
		{
			_parentField = v;
		}
		
		private var _suppressParentingErrors:Boolean
		
		/**
		 * A property to specify whether or not to suppress errors when attempting to parent
		 * objects. This is useful if some parts of the data need parenting and others do not, since
		 * some classes may have a parent property while others will not, and attempting to set a
		 * property that doesnt exist will always cause an error on all but dynamic classes. 
		 */
		public function get suppressParentingErrors():Boolean
		{
			return _suppressParentingErrors;
		}
		
		public function set suppressParentingErrors(value:Boolean):void
		{
			_suppressParentingErrors = value;
		}
		
		private var _ignoreArraysWhenParenting:Boolean;
		/**
		 * Whether or not an array should be counted as the parent of a child, or whether the object
		 * containing the array should be considered the parent.
		 * <p>For example, structural has its children contained within a list called "children". If
		 * <code>ignoreArraysWhenParenting</code> is set to false those children will have the array
		 * set as their parent, whereas if it is set to true, they will have the structural data
		 * object containing the array set as their parent.</p>
		 */
		public function get ignoreArraysWhenParenting():Boolean
		{
			return _ignoreArraysWhenParenting;
		}

		public function set ignoreArraysWhenParenting(v:Boolean):void
		{
			_ignoreArraysWhenParenting = v;
		}
		
		private var _deserializeUnmappedObjects:Boolean;
		
		/**
		 * Whether or not complex xml nodes that do not have an explicit mapping should be
		 * deserialized into anonymous objects or collections
		 */
		public function get deserializeUnmappedObjects():Boolean
		{
			return _deserializeUnmappedObjects;
		}
		
		public function set deserializeUnmappedObjects(value:Boolean):void
		{
			_deserializeUnmappedObjects = value;
		}
		
		private var _anonymousObjectType:Class
		
		/**
		 * The anonymous object type to be used as a class reference when deserializing a complex
		 * xml node with no explicit mapping.
		 */
		public function get anonymousObjectType():Class
		{
			return _anonymousObjectType;
		}
		
		public function set anonymousObjectType(value:Class):void
		{
			_anonymousObjectType = value;
		}
		
		private var _anonymousCollectionType:Class
		
		/**
		 * The anonymous collection type to be used as a class reference when deserializing a
		 * complex xml node with no explicit mapping.
		 */
		public function get anonymousCollectionType():Class
		{
			return _anonymousCollectionType;
		}
		
		public function set anonymousCollectionType(value:Class):void
		{
			_anonymousCollectionType = value;
		}
		
		private var _groupSameNamedUnmappedNodes:Boolean;
		
		/**
		 * Specifies how unmapped nodes should be deserialized - whether similarly named nodes
		 * should be grouped into a collection or whether its parent should be considered a
		 * collection that contains them. This property defaults to false.
		 * 
		 * <p>The following xml will serve as the source:</p>
		 * 
		 * <code>
		 * 
		 * 	<thing>
		 * 		<item id="a"/>
		 *		<item id="b"/>
		 *		<item id="c"/>
		 * 		<adfg>
		 *	</thing>
		 * 
		 * </code>
		 * 
		 * <p>If <code>groupSameNamedUnmappedNodes</code> is false the <code>thing</code> node will
		 * be converted into a collection and the deserialized <code>item</code> nodes added to it.
		 * Whereas if <code>groupSameNamedUnmappedNodes</code> is true the <code>thing</code> node
		 * will be deserialized to an object containing a property named <code>item</code> with
		 * the deserialized item nodes as its three children.</p>
		 * 
		 * <code>
		 * 
		 */
		public function get groupSameNamedUnmappedNodes():Boolean
		{
			return _groupSameNamedUnmappedNodes
		}
		
		public function set groupSameNamedUnmappedNodes(value:Boolean):void
		{
			_groupSameNamedUnmappedNodes = value;
		}
		
		private function get anonymousObjectClassReferencesDefined():Boolean
		{
			return anonymousObjectType && anonymousCollectionType;
		}
		
		/**
		 * Deserializes an XML object into a complex actionscript object heirarchy.
		 * 
		 * @param xml The XML object to be deserialized
		 * @param obj 
		 * @param parent 
		 * @return A complex actionscript object representing the XML heirarchy.
		 */
		public function deserialize(xml:XML, obj:*=null, parent:*=null):*
		{
			//Check if object exists
			if(!obj)
			{
				//Check if xml has complex content (maening sub nodes rather than simple text content) or any atrributes
				if(xml.hasComplexContent() || xml.attributes().length() > 0)
				{
					
					//Checking if a mapping can be found for the xml node name
					if(hasMapping(xml.localName()))
					{
						var classRef:Class = getMapping(xml.localName());
						obj = new classRef();
					}
					else
					{
						//Checking whether unmapped objects objects should be deserialized
						if(deserializeUnmappedObjects)
						{
							//Checking whether class references are defined for anonymous objects
							//and collections
							if(anonymousObjectClassReferencesDefined)
							{
								if(xml.parent() && xml.parent())
								{
									
								}
								
								obj = createAnonymousObject(xml);
								//trace("obj: " + xml.localName() + " - " + ReflectionUtils.getClassReference(obj));
							}
							else
							{
								throw new Error("Trying to deserialize unmapped object but anonymous object class references are not defined");
							}
						}
						else
						{
							throw new Error("Can't find mapping for node: " + xml.localName());
						}
					}
				}
				else
				{
					//Usually a simple node with simple content will contain a string but it may be
					//an empty collection, so have to check for explict isCollection flag via
					//the isCollectionNode() method
					
					use namespace deserializerNamespace;
										
					if(xml.@isCollection == "1" || xml.@isCollection == "true")
					{
						obj = createAnonymousObject(xml)
					}
					else if(!getMapping(xml.localName()))
					{
						return xml.toString();
					}
				}
			}
			
			//NOTE: Object has always been created by this point
			
			//Deserializing attributes
			for (var i:int = 0; i < xml.attributes().length(); i++)
			{
				//Get the current attribute
				var attName:String = String(xml.attributes()[i].name());
				
				//Creating the namespaced isCollection attribute name
				var namespacedIsCollectionAttName:String = ReflectionUtils.getFullyQualifiedClassName(XMLDeserializer) + "::isCollection";
				
				//Checking we arent trying to deserialize the isCollection marker attribute
				if(attName != namespacedIsCollectionAttName)
				{
					setProperty(obj, attName, xml.attributes()[i].toString());
				}
			}
			
			//Deserializing children
			for each(var childXML:XML in xml.children())
			{
				var child:Object = deserialize(childXML, null, obj);
				
				var numSiblingsWithChildNodeName:int = XMLUtils.getNumItemsWithName(xml, childXML.localName()); 
				
				
				//If the node has more than one child with the same name and
				//groupSameNamedUnmappedNodes is true push items with same name into property on parent which is an array.
				if(numSiblingsWithChildNodeName > 1 && groupSameNamedUnmappedNodes)
				{
					
					if( !obj.hasOwnProperty(childXML.localName()) )
					{
						obj[childXML.localName()] = new anonymousCollectionType();						
					}
					
					addItemToCollection(obj[childXML.localName()], child);
				}
				else
				{
					//Attempt to parent the objects
					if(isCollectionObject(obj))
					{
						tryParenting(ignoreArraysWhenParenting ? parent : obj, child);
						
						addItemToCollection(obj, child);
					}
					else
					{
						if(child)
						{
							tryParenting(ignoreArraysWhenParenting ? parent : obj, child);
						}
						
						setProperty(obj, childXML.localName(), child);
					}
					
				}
			}
			
			return obj;
		}
		
		private function addItemToCollection(collection:Object, item:Object):void
		{
			collectionStrategyMap.getStrategyByInstance(collection).addItem(collection, item);
		}
		
		private function hasMapping(identifier:String, context:Class=null, defaultToNoncontextualized:Boolean=true):Boolean
		{
			return !!getMapping(identifier, context, defaultToNoncontextualized);
		}
		
		private function getMapping(identifier:String, context:Class=null, defaultToNoncontextualized:Boolean=true):Class
		{
			if(map)
			{
				return map.getMapping(identifier, context, defaultToNoncontextualized);
			}
			
			return null;
		}
		
		private function createAnonymousObject(xml:XML):*
		{
			/* if(hasSameNamedUnmappedChildNodes(xml))
			{
				//if()
			} */
			
			//trace(xml.localName()+ " isCollectionNode(xml): " + isCollectionNode(xml))
			
			var classRef:Class = isCollectionNode(xml) ? anonymousCollectionType : anonymousObjectType;
			
			return new classRef();
		}
		
		private function hasSameNamedUnmappedChildNodes(xml:XML):Boolean
		{
			var childNodeNames:Array = [];
			var childNode:XML;
			for each(childNode in xml.children())
			{
				if(ArrayUtils.contains(childNodeNames, childNode.localName()))
				{
					return true;
				}
				childNodeNames.push(childNode.localName());
			}
			
			return false;
		}
		
		/**
		 * Returns whether or not an object is a collection, based on whether a strategy can be
		 * found in the collectionStrategyMap
		 * 
		 */
		private function isCollectionObject(obj:Object):Boolean
		{
			return !!collectionStrategyMap.getStrategyByInstance(obj);
		}
		
		/**
		 * <p>
		 * Returns whether or not a specified node is a collection node. This is detected in a one
		 * of three possible ways:
		 * </p>
		 * 
		 * <p>
		 * 1. The method firstly checks if an explicit mapping is present for the xml node name, if so an
		 * instance of the class reference is constructed and tested to see whether a corresponding
		 * collection strategy can be found. If this can be done, the node is representing a
		 * collection.
		 * </p>
		 * 
		 * <p>
		 * 2. The method then checks if the attribute "isCollection" is set to either "1" or "true".
		 * This must be put into the specific namespace "com.layerglue.lib.base.io.xml.Deserializer".
		 * See example below:
		 * <code>
		 *	<?xml version="1.0"?>
		 *	<root xmlns:dsr="com.layerglue.lib.base.io.xml.Deserializer">
		 *		<children dsr:isCollection="1">
		 *			<item>
		 *				<id>123</id>
		 *			</item>
		 *			<item>
		 *				<id>456</id>
		 *			</item>
		 *		</children>
		 *	</root>
		 * </code>
		 * </p>
		 * 
		 * <p>
		 * 3. As a last resort the method checks to see whether the node contains more than one sub-
		 * node with the same name. If so, this is considered a collection.
		 * </p> 
		 */
		public function isCollectionNode(xml:XML):Boolean
		{
			//If groupSameNamedUnmappedNodes is true this should always return false, as there isnt
			//really a concept of a collection, apart from when there are multiple same named nodes,
			//and these are grouped into a collection as a property named after their shared name on
			//the parent object.
			if(groupSameNamedUnmappedNodes)
			{
				return false 
			}
			else
			{
				
				
				//Check 1 - Explicit mapping - See documentation above
				if(map)
				{
					var classRef:Class = getMapping(xml.localName());
					
					if( classRef )
					{
						var possibleCollection:* = collectionStrategyMap.getStrategyByInstance(new classRef());
						return possibleCollection != null;
					}
				}
				
				//Check 2 - Explicit "isCollection" attribute flag - See documentation above
				use namespace deserializerNamespace;
				
				if(xml.@isCollection == "1" || xml.@isCollection == "true")
				{
					return true;
				}
				
				//Check 3 - Multiple similarly named subnodes - See documentation above
				if(xml.children().length() >= 1 || getMapping(xml.localName()) )
				{
					for each(var child:XML in xml.children())
					{
						//TODO - Look into XMLUtils.getNumItemsWithName throwing an error when name
						//argument is null.
						if(child.localName() && XMLUtils.getNumItemsWithName(xml, child.localName()) > 1)
						{
							return true;
						}
					}
				}
				
				//Default to false
				return false;
				
				
				
			}
			
			
			
		}
		
		/**
		 * Attempts to set the <code>parentField</code> property on the child object to the
		 * specified parent value being passed in. The string value <code>parentField</code> can be
		 * defined on a per deserializer basis.
		 */
		private function tryParenting(parent:*, child:*):void
		{
			if(parentField && child.hasOwnProperty(parentField))
			{
				if(suppressParentingErrors)
				{
					try
					{
						child[parentField] = parent;
					}
					catch(error:Error)
					{
						//trace("caught the parenting error")
					}
				}
				else
				{
					child[parentField] = parent;
				}
			}
		}
		
		/**
		 * Sets a property on an object, and evaluates Boolean values to being true if the value
		 * in the xml is either "1" or "true";
		 */
		private function setProperty(obj:*, propName:String, value:*):void
		{
			if( (obj as Object).hasOwnProperty(propName) || obj is anonymousObjectType)
			{
				if(obj[propName] is Boolean)
				{
					if(value == "true" || value == "1")
					{
						obj[propName] = true;
					}
					else
					{
						obj[propName] = false;
					}
				}
				else
				{
					obj[propName] = value;
				}
			}
			else
			{
				throw new Error("Trying to set property (via attribute) that doesn't exist obj: " + obj + ", property: " + propName);
			}
		}
		
	}
}