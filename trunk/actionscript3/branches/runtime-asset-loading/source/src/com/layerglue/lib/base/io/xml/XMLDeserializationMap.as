package com.layerglue.lib.base.io.xml
{
	import com.layerglue.lib.base.collections.HashMap;
	
	/**
	 * Specifies a mapping of string names to classes. This is used as a lookup table
	 * in the deserializer. Typically this is subclassed and mappings are added in
	 * the constructor.
	 */
	public class XMLDeserializationMap extends Object
	{
		private var _nonContextualizedReferences:HashMap;
		private var _contexts:HashMap;
		
		public function XMLDeserializationMap()
		{
			super();
			
			_nonContextualizedReferences = new HashMap();
			_contexts = new HashMap();
		}
		
		/**
		 * Adds an identifier to class mapping and has an optional parameter of a context, which
		 * allows the same identifier to be used in different contexts and return a different class.
		 * </p>For example, the Dog and Cat classes both extend the Pet class which has a
		 * property <code>favouriteToy</code> as described in the xml below:</p>   
		 <pre>
		 	&lt;dog&gt;
		  		&lt;favouriteToy&gt;
		  			&lt;size&gt;2&lt;/size&gt;
		  		&lt;/favouriteToy&gt;
		  	&lt;dog&gt;
		  	&lt;cat&gt;
		  		&lt;favouriteToy&gt;
		  			&lt;size&gt;1&lt;/size&gt;
		  		&lt;/favouriteToy&gt;
		  	&lt;cat&gt;
		  	&lt;pet&gt;
		  		&lt;favouriteToy&gt;
		  			&lt;size&gt;0&lt;/size&gt;
		  		&lt;/favouriteToy&gt;
		 	&lt;pet&gt;
		 </pre>
		 * 
		 * <p>In our application the <code>Pet</code> class' favourite toy is a default
		 * <code>Toy</code> object, the <code>Dog</code> a <code>Stick</code> and the
		 * <code>Cat</code> a Ball which both extend the <code>Toy</code> class, the code below
		 * specifies this.</p>
		 <pre>
			 addMapping("favouriteToy", Toy);
			 addMapping("favouriteToy", Stick, DogsPage);
			 addMapping("favouriteToy", Ball, CatsPage);
		 </pre>
		 * 
		 * @param identifier		The name of the property to be mapped to a class
		 * @param classReference	The class to be mapped to
		 * @param context			An optional parameter specifying that the identifier should
		 * 							point to a specific class only when it is in the context of a
		 * 							particular class 
		 * 							
		 */
		public function addMapping(identifier:String, classReference:Class, context:Class=null):void
		{
			if(context)
			{
				var contextMap:HashMap = _contexts.get(context);
				//First check to see whether a map exists for that class
				if(!contextMap)
				{
					_contexts.put(context, new HashMap());
					contextMap = _contexts.get(context);
				}
				
				contextMap.put(identifier, classReference);
			}
			else
			{
				_nonContextualizedReferences.put(identifier, classReference);
			}
		}
		
		/**
		 * Removes a mapping from the map
		 * 
		 * @param identifier	The name of the mapping
		 * @param context		An optional parameter to specify a context for the mapping
		 */
		public function removeMapping(identifier:String, context:Class=null):void
		{
			if(context)
			{
				var contextMap:HashMap = _contexts.get(context);
				if(contextMap)
				{
					delete contextMap.remove(identifier);
				}
				
			}
			else
			{
				delete _nonContextualizedReferences.remove(identifier);
			}
		}
		
		/**
		 * Remove all mappings.
		 */
		public function removeAllMappings():void
		{
			_nonContextualizedReferences.removeAll();
			_contexts.removeAll();
		}
		
		/**
		 * Returns whether or not a certain mapping is contained by the map.
		 * 
		 * @param identifier			The name of a property mapped to a class
		 * @param context				An optional parameter specifying that the identifier should
		 * 								point to a specific class only when it is in the context of
		 * 								a paricular class
		 * @defaultToNoncontextualized	An optional parameter specifying whether if a mapping is not
		 * 								found in a particular context whether the non-contextualized
		 * 								mapping should be used.
		 */
		public function containsMapping(identifier:String, context:Class=null, defaultToNoncontextualized:Boolean=true):Boolean
		{
			return !!getMapping(identifier, context, defaultToNoncontextualized);
		}
		
		/**
		 * Returns a mapping
		 * 
		 * @param identifier			The name of a property mapped to a class
		 * @param context				An optional parameter specifying that the identifier should
		 * 								point to a specific class only when it is in the context of
		 * 								a paricular class
		 * @defaultToNoncontextualized	An optional parameter specifying whether if a mapping is not
		 * 								found in a particular context whether the non-contextualized
		 * 								mapping should be used.
		 */
		public function getMapping(identifier:String, context:Class=null, defaultToNoncontextualized:Boolean=true):Class
		{
			var contextualizedRef:Class;
			//Try to get a contextualized reference
			if(context && _contexts.get(context) && _contexts.get(context).get(identifier))
			{
				contextualizedRef = _contexts.get(context).get(identifier);
			}
			
			//If no contextualized reference exists and we shouldnt default, return a null
			if(defaultToNoncontextualized)
			{
				return contextualizedRef ?  contextualizedRef : _nonContextualizedReferences.get(identifier);
			}
			
			return null;
		}
	}
}