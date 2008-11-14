package com.client.project.io
{
	import com.client.project.locators.ModelLocator;
	import com.client.project.maps.StructureDeserializationMap;
	import com.client.project.vo.StructureRoot;
	import com.layerglue.flex3.base.loaders.CSSStyleLoader;
	import com.layerglue.flex3.base.preloader.PreloadManager;
	import com.layerglue.lib.base.events.EventListener;
	import com.layerglue.lib.base.io.FlashVars;
	import com.layerglue.lib.base.io.LoadManager;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.xml.XMLDeserializer;
	import com.layerglue.lib.base.loaders.XmlLoader;
	import com.layerglue.lib.base.localisation.Locale;
	import com.layerglue.lib.base.substitution.ISubstitutionSource;
	import com.layerglue.lib.base.substitution.XMLSubstitutor;
	import com.layerglue.lib.base.substitution.sources.FlatXMLSubstitutionSource;
	import com.layerglue.lib.base.substitution.sources.MultiSubstitutionSource;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
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
		
		private var _loadManagerListener:EventListener;
		
		public var structureRoot:StructureRoot;
		
		private var _regionalCSSLoader:CSSStyleLoader;
		
		
		public function InitialLoadManager()
		{
			super();
			
			_loader = PreloadManager.getInstance().initialLoadManager;
			
			_loadManagerListener = new EventListener(
						PreloadManager.getInstance().initialLoadManager,
						Event.COMPLETE,
						loaderCompleteHandler);
			
			initialize();
		}
		
		private var _loader:LoadManager;
		
		public function get loader():LoadManager
		{
			return _loader;
		}
		
		public function initialize():void
		{			
			//Creating empty loader as url can only be defined after xml data has been deserialized.
			_regionalCSSLoader = new CSSStyleLoader(new URLRequest());
			
			var modelLocator:ModelLocator = ModelLocator.getInstance();
			modelLocator.locale = new Locale(FlashVars.getInstance().getValue("locale"));
			
			var globalConfigToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest("flash-assets/xml/configuration/config_global.xml")),
					globalConfigCompleteHandler,
					errorHandler,
					0.025);
			
			var localeConfigToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest("flash-assets/xml/configuration/locales/config_" + modelLocator.locale.code + ".xml")),
					localeConfigCompleteHandler,
					errorHandler,
					0.025);
			
			var localeCopyToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest("flash-assets/xml/copy/locales/copy_" + modelLocator.locale.code + ".xml")),
					localeCopyCompleteHandler,
					errorHandler,
					0.025);
			
			var unsubstitutedStructureToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest("flash-assets/xml/structure/structure-unsubstituted.xml")),
					structureUnpopulatedCompleteHandler,
					errorHandler,
					0.025);
			
			var regionalCSSToken:LoadManagerToken = new LoadManagerToken(
					_regionalCSSLoader,
					regionalCompiledCSSCompleteHandler,
					errorHandler,
					0.39);
			
			_loader.addItem(globalConfigToken);						
			_loader.addItem(localeConfigToken);							
			_loader.addItem(localeCopyToken);							
			_loader.addItem(unsubstitutedStructureToken);							
			_loader.addItem(regionalCSSToken);
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
			
			var region:String = _localeConfigSource.getValueByReference("region");
			
			//Simulate availability of config data by setting the regional css path 
			_regionalCSSLoader.request.url = "flash-assets/compiled-css/regions/" + region + ".swf?cacheBuster=" + Math.random();
			
			_loader.loadNext();
		}
		
		private function regionalCompiledCSSCompleteHandler(event:Event):void
		{
			_loader.loadNext();
		}
		
		private function loaderCompleteHandler(event:Event):void
		{
			dispatchEvent(new Event(Event.COMPLETE));
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