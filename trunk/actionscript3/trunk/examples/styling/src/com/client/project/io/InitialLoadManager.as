package com.client.project.io
{
	import com.client.project.locators.ModelLocator;
	import com.client.project.maps.StructureDeserializationMap;
	import com.layerglue.flex3.base.loaders.CSSStyleLoader;
	import com.layerglue.lib.base.io.LoadManager;
	import com.layerglue.lib.base.io.xml.XMLDeserializer;
	import com.layerglue.lib.base.loaders.XmlLoader;
	import com.layerglue.lib.base.localisation.Locale;
	import com.layerglue.lib.base.substitution.ISubstitutionSource;
	import com.layerglue.lib.base.substitution.XMLSubstitutor;
	import com.layerglue.lib.base.substitution.sources.FlatXMLSubstitutionSource;
	import com.layerglue.lib.base.substitution.sources.MultiSubstitutionSource;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mx.core.Application;
	
	/**
	 * Handles the loading, substitution and deserialization of any XML data that's
	 * required before the application begins. 
	 */
	public class InitialLoadManager extends LoadManager
	{
		//Defining properties to hold XML Substitutors
		private var _globalConfigSource:ISubstitutionSource;
		private var _localeConfigSource:ISubstitutionSource;
		private var _copySource:ISubstitutionSource;
		
		protected var modelLocator:ModelLocator;
		
		public function InitialLoadManager()
		{
			super();
			
			initialize();
		}
		
		public function initialize():void
		{
			modelLocator = ModelLocator.getInstance();
			//FlashVars.initialize(Application.application.root);
			modelLocator.locale = new Locale(Application.application.parameters.locale);
			
			addItem(
				new XmlLoader(new URLRequest("flash-assets/xml/configuration/config_global.xml")),
				globalConfigCompleteHandler,
				errorHandler);
			
			addItem(
				new XmlLoader(new URLRequest("flash-assets/xml/configuration/locales/config_" + modelLocator.locale.code + ".xml")),
				localeConfigCompleteHandler,
				errorHandler);
			
			addItem(
				new XmlLoader(new URLRequest("flash-assets/xml/copy/locales/copy_" + modelLocator.locale.code + ".xml")),
				localeCopyCompleteHandler,
				errorHandler);
				
			addItem(
				new XmlLoader(new URLRequest("flash-assets/xml/structure/structure-unsubstituted.xml")),
				structureUnpopulatedCompleteHandler,
				errorHandler);
			
			// TODO: switch region on locale config
			addItem(
				new CSSStyleLoader(new URLRequest("flash-assets/compiled-css/regions/western.swf")),
				regionalCompiledCSSCompleteHandler,
				errorHandler);
		}
		
		private function globalConfigCompleteHandler(event:Event):void
		{
			_globalConfigSource = new FlatXMLSubstitutionSource((event.target as XmlLoader).typedData, "item");
			loadNext();
		}
		
		private function localeConfigCompleteHandler(event:Event):void
		{
			_localeConfigSource = new FlatXMLSubstitutionSource((event.target as XmlLoader).typedData, "item");
			loadNext();
		}
		
		private function localeCopyCompleteHandler(event:Event):void
		{
			_copySource = new FlatXMLSubstitutionSource((event.target as XmlLoader).typedData, "item");
			loadNext();
		}
		
		private function structureUnpopulatedCompleteHandler(event:Event):void
		{
			populateStructuralDataXML((event.target as XmlLoader).typedData);
			loadNext();
		}
		
		private function regionalCompiledCSSCompleteHandler(event:Event):void
		{
			loadNext();
		}
		
		private function errorHandler(event:Event):void
		{
			trace("Error loading file");
		}
		
		private function populateStructuralDataXML(xml:XML):void
		{
			var source:MultiSubstitutionSource = new MultiSubstitutionSource();
			source.addItem(_globalConfigSource);
			source.addItem(_localeConfigSource);
			source.addItem(_copySource);
			
			var substitutor:XMLSubstitutor = new XMLSubstitutor("@", "@");
			var populatedXML:XML = substitutor.process(xml, source);
			
			deserializeStructuralData(populatedXML);
		}
		
		private function deserializeStructuralData(xml:XML):void
		{
			var deserializer:XMLDeserializer = new XMLDeserializer();
			deserializer.map = new StructureDeserializationMap();
			var structure:* = deserializer.deserialize(xml);
			modelLocator.structure = structure;			
		}
		
	}
}