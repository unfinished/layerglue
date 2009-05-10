package com.layerglue.lib.base.substitution.sources
{
	import com.layerglue.lib.base.substitution.ISubstitutionSource;
	
	/**
	 * <p>For XML structured as below:</p>
	 * <p>Note: The top level node is not required to be named copyDeck and child nodes can be
	 * nested inside other structures as long as they are all named uniformly and the same as the
	 * value passed in through the constructor</p>
	 * <code>
	 *	 <copyDeck>
	 * 		<copyItem id="header.home.label">HOME</copyItem>
	 * 		<copyItem id="header.contact.label">CONTACT</copyItem>
	 * 	</copyDeck>
	 * </code>
	 */
	public class FlatXMLSubstitutionSource extends SubstitutionSource implements ISubstitutionSource
	{
		private var _xml:XML;
		
		private var _copyItemNodeName:String;
		
		public function get copyItemNodeName():String
		{
			return _copyItemNodeName;
		}
		
		public function FlatXMLSubstitutionSource(xml:XML, copyItemNodeName:String)
		{
			super();
			
			_copyItemNodeName = copyItemNodeName;
			deserialize(xml);
		}
		
		protected function deserialize(xml:XML):void
		{
			_xml = xml;
			clearMap();
			clearReferences();
			
			//Iterate through all the row nodes in the document
			for each(var rowXML:XML in _xml..*.(name()==_copyItemNodeName))
			{
				addItem(rowXML.@id.toString(), rowXML.text(), rowXML.@type.toString());
			}
		}
		
	}
}