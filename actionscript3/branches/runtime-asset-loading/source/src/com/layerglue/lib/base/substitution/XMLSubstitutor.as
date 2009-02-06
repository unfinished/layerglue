package com.layerglue.lib.base.substitution
{
	
	public class XMLSubstitutor extends Object implements ISubstitutor
	{
		
		public function XMLSubstitutor(openingDelimeter:String, closingDelimeter:String)
		{
			super();
			
			this.openingDelimeter = openingDelimeter;
			this.closingDelimeter = closingDelimeter;
		}
		
		private var _openingDelimeter:String;
		
		/**
		 * The delimeter signifying the start of a value to be substituted.
		 * 
		 * @see closingDelimeter
		 */
		public function get openingDelimeter():String
		{
			return _openingDelimeter;
		}
		
		public function set openingDelimeter(value:String):void
		{
			_openingDelimeter = value;
		}
		
		private var _closingDelimeter:String;
		
		/**
		 * The delimeter signifying the end of a value to be substituted.
		 * 
		 * @see openingDelimeter
		 */
		public function get closingDelimeter():String
		{
			return _closingDelimeter;
		}
		
		public function set closingDelimeter(value:String):void
		{
			_closingDelimeter = value;
		}
		 
		public function process(unsubstitutedData:*, strategy:ISubstitutionSource):*
		{
			var xmlCopy:XML = (unsubstitutedData as XML).copy();
			
			// Iterate through nodes
			var nodes:XMLList = getSubstitutionNodes(xmlCopy);
			for each (var n:XML in nodes)
			{
				n.children()[0] = trySubstitution(strategy, n.children()[0].toString());
			}
			
			// Iterate through attributes
			var attributes:XMLList = getSubstitutionAttributes(xmlCopy);
			for (var i:int = 0; i < attributes.length(); i++)
			{
				attributes[i] = trySubstitution(strategy, attributes[i].toString());
			}
			
			return xmlCopy;
		}
		
		public function getMissingDestinationKeys(strategy:ISubstitutionSource):Array
		{
			// TODO: Need to get a list of ALL keys from source strategy
			// before we can compare them against what is stored in the XML here
			return [];
		}
		
		public function getMissingSourceKeys(unsubstitutedData:*, strategy:ISubstitutionSource):Array
		{
			var xmlCopy:XML = (unsubstitutedData as XML).copy();
			
			var compareArray:Array = new Array();
			
			// Push NODE-BASED substitution keys into array if they are not found in the source
			var nodeList:XMLList = getSubstitutionNodes(xmlCopy);
			for each (var n:XML in nodeList)
			{
				// The original key is returned un-changed if it is not found, so we compare against that
				var nodeKey:String = n.children()[0].toString();
				if (trySubstitution(strategy, nodeKey) == nodeKey)
				{
					compareArray.push(nodeKey);
				}
			}
			
			// Push ATTRIBUTE-BASED substitution keys into array if they are not found in the source
			var attributes:XMLList = getSubstitutionAttributes(xmlCopy);
			for (var i:int = 0; i < attributes.length(); i++)
			{
				// The original key is returned un-changed if it is not found, so we compare against that
				// FIX: Because getSubstitutionAttributes() returns _all_ attributes we need to add
				// a conditional to check whether the key should substitute.
				var attKey:String = attributes[i].toString();
				if (conformsToDelimeters(attKey) && (trySubstitution(strategy, attKey) == attKey))
				{
					compareArray.push(attKey);
				}
			}
			
			return compareArray;
		}
		
		protected function getSubstitutionAttributes(xml:XML):XMLList
		{
			var attList:XMLList = xml..*.@*;
			
			// BUG: This doesn't work because deleting nodes from the XMLList actually deletes them for real.
			// Can't seem to return a usable list of substitution attributes using e4x
			// So we're resorting to a manual loop to remove non-substitution entries
			/* for (var i:int = attList.length()-1; i > 0; i--)
			{
				if (!shouldSubstitute(attList[i].toString()))
				{
					delete attList[i];
				}
			} */
			
			return attList;
		}
		
		protected function getSubstitutionNodes(xml:XML):XMLList
		{
			//var nodes:XMLList = xml..*.(hasSimpleContent()).(text().toString().charAt(0) == "@");
			var nodes:XMLList = xml..*.(hasSimpleContent()).(conformsToDelimeters(text().toString()));
			return nodes;
		}
		
		protected function trySubstitution(strategy:ISubstitutionSource, value:String):String
		{
			if(conformsToDelimeters(value))
			{
				// Returns the referenced string if found, else it returns the original key
				var s:String = strategy.getValueByReference(stripDelimiters(value));
				return s ? s : value;
			}
			return value;
		}
		
		private function conformsToDelimeters(value:String):Boolean
		{
			return 	value.slice(0, openingDelimeter.length) == openingDelimeter && value.slice(value.length-closingDelimeter.length, value.length)
		}
		
		private function stripDelimiters(value:String):String
		{
			return value.slice(openingDelimeter.length, value.length-closingDelimeter.length)
		}
	}
}