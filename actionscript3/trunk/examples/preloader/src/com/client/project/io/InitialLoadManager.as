package com.client.project.io
{
	import com.client.project.maps.StructureDeserializationMap;
	import com.client.project.vo.StructureRoot;
	import com.layerglue.flex3.base.loaders.CSSStyleLoader;
	import com.layerglue.flex3.base.preloader.PreloadManager;
	import com.layerglue.lib.base.io.FlashVars;
	import com.layerglue.lib.base.io.LoadManager;
	import com.layerglue.lib.base.io.ProportionalLoadManagerToken;
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
	public class InitialLoadManager extends EventDispatcher
	{
		//Defining properties to hold XML Substitutors
		private var _globalConfigSource:ISubstitutionSource;
		private var _localeConfigSource:ISubstitutionSource;
		private var _copySource:ISubstitutionSource;
		
		public var structureRoot:StructureRoot;
		
		private var _regionalCSSLoader:CSSStyleLoader;
		
		
		public function InitialLoadManager()
		{
			super();
			
			_loader = PreloadManager.getInstance().initialLoadManager;
			
			initialize();
		}
		
		private var _loader:LoadManager;
		
		public function get loader():LoadManager
		{
			return _loader;
		}
		
		public function initialize():void
		{
			FlashVars.initialize(Application.application.root);
			var locale:String = FlashVars.getInstance().getValue("locale");
			
			//Creating empty loader as url can only be defined after xml data has been deserialized.
			_regionalCSSLoader = new CSSStyleLoader(new URLRequest());
			
			var globalConfigItem:ProportionalLoadManagerToken = new ProportionalLoadManagerToken(
										new XmlLoader(new URLRequest("flash-assets/xml/configuration/config_global.xml")),
										globalConfigCompleteHandler,
										errorHandler,
										0.025);
			_loader.addItem(globalConfigItem);
			
			var localeConfigItem:ProportionalLoadManagerToken = new ProportionalLoadManagerToken(
										new XmlLoader(new URLRequest("flash-assets/xml/configuration/locales/config_" + locale + ".xml")),
										localeConfigCompleteHandler,
										errorHandler,
										0.025);
			_loader.addItem(localeConfigItem);
					
			var localeCopyItem:ProportionalLoadManagerToken = new ProportionalLoadManagerToken(
										new XmlLoader(new URLRequest("flash-assets/xml/copy/locales/copy_" + locale + ".xml")),
										localeCopyCompleteHandler,
										errorHandler,
										0.025);
			_loader.addItem(localeCopyItem);
										
			var structureItem:ProportionalLoadManagerToken = new ProportionalLoadManagerToken(
										new XmlLoader(new URLRequest("flash-assets/xml/structure/structure-unsubstituted.xml")),
										structureUnpopulatedCompleteHandler,
										errorHandler,
										0.025);
			_loader.addItem(structureItem);
								
			var regionalCSSItem:ProportionalLoadManagerToken = new ProportionalLoadManagerToken(
										_regionalCSSLoader,
										regionalCompiledCSSCompleteHandler,
										errorHandler,
										0.3);
			_loader.addItem(regionalCSSItem);
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
			
			//Simulating setting the structural data here
			_regionalCSSLoader.request.url = "flash-assets/compiled-css/regions/western.swf?cacheBuster=" + Math.random();
			
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