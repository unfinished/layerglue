package com.client.project.io
{
	import com.client.project.maps.StructureDeserializationMap;
	import com.client.project.vo.StructureRoot;
	import com.layerglue.flex3.base.loaders.CSSStyleLoader;
	import com.layerglue.flex3.base.preloader.PreloaderManager;
	import com.layerglue.lib.base.io.FlashVars;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	import com.layerglue.lib.base.io.xml.XMLDeserializer;
	import com.layerglue.lib.base.loaders.XmlLoader;
	import com.layerglue.lib.base.substitution.ISubstitutionSource;
	import com.layerglue.lib.base.substitution.XMLSubstitutor;
	import com.layerglue.lib.base.substitution.sources.FlatXMLSubstitutionSource;
	import com.layerglue.lib.base.substitution.sources.MultiSubstitutionSource;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	import mx.core.Application;
	
	/**
	 * Handles the loading, substitution and deserialization of any XML data that's
	 * required before the application begins. 
	 */
	public class InitialLoadManagerWrapper extends EventDispatcher
	{
		private var _locale:String;
		
		//Defining properties to hold XML Substitutors
		private var _globalConfigSource:ISubstitutionSource;
		private var _localeConfigSource:ISubstitutionSource;
		private var _copySource:ISubstitutionSource;
		
		public var structureRoot:StructureRoot;
		
		
		
		
		
		private var _globalConfigXMLLoader:XmlLoader;
		private var _localeConfigXMLLoader:XmlLoader;
		private var _localeCopyXMLLoader:XmlLoader;
		private var _structureUnsubstitutedXMLLoader:XmlLoader;
		private var _regionalCSSLoader:CSSStyleLoader;
		
		
		public function InitialLoadManagerWrapper()
		{
			super();
			
			_loader = PreloaderManager.getInstance().initialLoadManager;
			
			initialize();
		}
		
		private var _loader:ProportionalLoadManager
		
		public function get loader():ProportionalLoadManager
		{
			return _loader;
		}
		
		public function initialize():void
		{
			FlashVars.initialize(Application.application.root);
			_locale = FlashVars.getInstance().getValue("locale");
			
			_loader.addItem(
				new XmlLoader(new URLRequest("flash-assets/xml/configuration/config_global.xml")),
				globalConfigCompleteHandler,
				errorHandler);
			
			_loader.addItem(
				new XmlLoader(new URLRequest("flash-assets/xml/configuration/locales/config_" + _locale + ".xml")),
				localeConfigCompleteHandler,
				errorHandler);
			
			_loader.addItem(
				new XmlLoader(new URLRequest("flash-assets/xml/copy/locales/copy_" + _locale + ".xml")),
				localeCopyCompleteHandler,
				errorHandler);
				
			_loader.addItem(
				new XmlLoader(new URLRequest("flash-assets/xml/structure/structure-unsubstituted.xml")),
				structureUnpopulatedCompleteHandler,
				errorHandler);
			
			
			//--------------------------------------------------------------------------------------
			
			_regionalCSSLoader = new CSSStyleLoader(new URLRequest());
			
			_loader.addItem(
				_regionalCSSLoader,
				regionalCompiledCSSCompleteHandler,
				errorHandler);
			
			trace("_regionalCSSLoader.request.url: " + _regionalCSSLoader.request.url);
			_regionalCSSLoader.request.url = "flash-assets/compiled-css/regions/western.swf";
			trace("_regionalCSSLoader.request.url: " + _regionalCSSLoader.request.url);
		}
		
		public function start():void
		{
			_loader.start();
		}
		
		private function globalConfigCompleteHandler(event:Event):void
		{
			_globalConfigSource = new FlatXMLSubstitutionSource((event.target as XmlLoader).typedData, "item");
			_loader.loadNext();
		}
		
		private function localeConfigCompleteHandler(event:Event):void
		{
			_localeConfigSource = new FlatXMLSubstitutionSource((event.target as XmlLoader).typedData, "item");
			_loader.loadNext();
		}
		
		private function localeCopyCompleteHandler(event:Event):void
		{
			_copySource = new FlatXMLSubstitutionSource((event.target as XmlLoader).typedData, "item");
			_loader.loadNext();
		}
		
		private function structureUnpopulatedCompleteHandler(event:Event):void
		{
			populateStructuralDataXML((event.target as XmlLoader).typedData);
			_loader.loadNext();
		}
		
		private function regionalCompiledCSSCompleteHandler(event:Event):void
		{
			_loader.loadNext();
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
			structureRoot = structure;			
		}
		
	}
}