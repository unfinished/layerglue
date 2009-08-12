package com.client.project.io
{
	import com.client.project.locators.ModelLocator;
	import com.client.project.maps.StructureDeserializationMap;
	import com.layerglue.flash.loaders.DisplayLoader;
	import com.layerglue.flash.preloader.FlashPreloadManager;
	import com.layerglue.flash.styles.LGStyleCollection;
	import com.layerglue.flash.styles.LGStyleManager;
	import com.layerglue.lib.base.events.EventListener;
	import com.layerglue.lib.base.io.FlashVars;
	import com.layerglue.lib.base.io.LoadManager;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.xml.XMLDeserializer;
	import com.layerglue.lib.base.loaders.XmlLoader;
	import com.layerglue.lib.base.localisation.Locale;
	import com.layerglue.lib.base.substitution.ISubstitutionSource;
	import com.layerglue.lib.base.substitution.XMLSubstitutor;
	import com.layerglue.lib.base.substitution.sources.ExcelSubstitutionSource;
	import com.layerglue.lib.base.substitution.sources.FlatXMLSubstitutionSource;
	import com.layerglue.lib.base.substitution.sources.MultiSubstitutionSource;

	import flash.display.Loader;
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
		
		public function get globalConfigSource():ISubstitutionSource
		{
			return _globalConfigSource;
		}
		
		private var _localeConfigSource:ISubstitutionSource;
		
		public function get localeConfigSource():ISubstitutionSource
		{
			return _localeConfigSource;
		}
		
		private var _localeCopySource:ISubstitutionSource;
		
		public function get localeCopySource():ISubstitutionSource
		{
			return _localeCopySource;
		}
		
		private var _loadManagerListener:EventListener;
		
		private var _regionalFontLoader:DisplayLoader;
		
		
		public function InitialLoadManager()
		{
			super();
			
			_loader = FlashPreloadManager.getInstance().loadManager;
			 
			_loadManagerListener = new EventListener(
						_loader,
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
			_regionalFontLoader = new DisplayLoader(new URLRequest());
			
			var modelLocator:ModelLocator = ModelLocator.getInstance();
			modelLocator.locale = new Locale(FlashVars.getInstance().getValue("locale"));
			
			var useDyamicData:Boolean = false;//FlashVars.getInstance().getValue("useDynamicData") == "true";
			
			var localeConfigPath:String = "flash-assets/xml/configuration/locales/config_" + modelLocator.locale.code + ".xml";;
			var localeCopyPath:String = "flash-assets/xml/copy/locales/copy_excel_" + modelLocator.locale.code + ".xml";
			
			var globalConfigToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest("flash-assets/xml/configuration/config_global.xml")),
					globalConfigCompleteHandler,
					errorHandler,
					0.01);
			
			var localeConfigToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest(localeConfigPath)),
					localeConfigCompleteHandler,
					errorHandler,
					0.01);
			
			var localeCopyToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest(localeCopyPath)),
					localeCopyCompleteHandler,
					errorHandler,
					0.01);
			
			var unsubstitutedStructureToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest("flash-assets/xml/structure/structure-unsubstituted.xml")),
					structureUnpopulatedCompleteHandler,
					errorHandler,
					0.01);
			
			var regionalCompiledFontToken:LoadManagerToken = new LoadManagerToken(
					_regionalFontLoader,
					regionalCompiledFontCompleteHandler,
					errorHandler,
					0.36);
			
			_loader.addItem(globalConfigToken);						
			_loader.addItem(localeConfigToken);							
			_loader.addItem(localeCopyToken);							
			_loader.addItem(unsubstitutedStructureToken);							
			_loader.addItem(regionalCompiledFontToken);
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
			//_localeConfigSource = new DelimitedValuesSubstitutionSource(event.target.data, "\n", ",", 1, 2, 0, "#");
			_loader.loadNext();
		}
		
		private function localeCopyCompleteHandler(event:Event):void
		{
			//_copySource = new FlatXMLSubstitutionSource((event.target as XmlLoader).typedData, "item");
			//_localeCopySource = new DelimitedValuesSubstitutionSource(event.target.data, "\n", ",", 1, 3, 0, "#");
			_localeCopySource = new ExcelSubstitutionSource((event.target as XmlLoader).typedData, 2, 4, 1, "#");
			
			trace("_localeCopySource getValue: "+_localeCopySource.getValue("project.title"));
			
			_loader.loadNext();
		}
		
		private function structureUnpopulatedCompleteHandler(event:Event):void
		{
			populateStructuralDataXML((event.target as XmlLoader).typedData);
			
			var region:String = _localeConfigSource.getValue("region");
			_regionalFontLoader.request.url = "flash-assets/fonts/" + region + ".swf";
			
			_loader.loadNext();
		}
		
		private function regionalCompiledFontCompleteHandler(event:Event):void
		{
			LGStyleManager.getInstance().registerStyle((event.target as Loader).content as LGStyleCollection);
			
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
		
		private function get regionName():String
		{
			if(!_localeConfigSource)
			{
				throw new Error("Tried to access _localeConfigSource before before locale config data has been loaded and deserialized.");
			}
			
			return _localeConfigSource.getValue("region");
		}
		
		private function populateStructuralDataXML(xml:XML):void
		{
			var source:MultiSubstitutionSource = new MultiSubstitutionSource();
			source.addItem(_globalConfigSource);
			source.addItem(_localeConfigSource);
			source.addItem(_localeCopySource);
			
			var substitutor:XMLSubstitutor = new XMLSubstitutor("@", "@");
			var populatedXML:XML = substitutor.process(xml, source);
			
			deserializeStructuralData(populatedXML);
		}
		
		private function deserializeStructuralData(xml:XML):void
		{
			var deserializer:XMLDeserializer = new XMLDeserializer();
			deserializer.map = new StructureDeserializationMap();
			var structure:* = deserializer.deserialize(xml);
			ModelLocator.getInstance().structure = structure;
		}
		
	}
}