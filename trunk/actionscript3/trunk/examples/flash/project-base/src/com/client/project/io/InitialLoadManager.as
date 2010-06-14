package com.client.project.io
{
	import com.client.project.constants.LoadProportionConstants;
	import com.client.project.maps.StructureDeserializationMap;
	import com.client.project.model.proxies.AssetLibraryProxy;
	import com.client.project.model.proxies.ConfigProxy;
	import com.client.project.model.proxies.CopyProxy;
	import com.client.project.model.proxies.StructuralDataProxy;
	import com.client.project.structure.Site;
	import com.layerglue.flash.events.FlashPreloadManagerEvent;
	import com.layerglue.flash.loaders.DisplayLoader;
	import com.layerglue.flash.preloader.FlashPreloadManager;
	import com.layerglue.flash.styles.LGStyleCollection;
	import com.layerglue.flash.styles.LGStyleManager;
	import com.layerglue.lib.base.assets.AssetLibrary;
	import com.layerglue.lib.base.collections.IKeyValuePairCollection;
	import com.layerglue.lib.base.io.FlashVars;
	import com.layerglue.lib.base.io.LoadManager;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.xml.XMLDeserializer;
	import com.layerglue.lib.base.loaders.XmlLoader;
	import com.layerglue.lib.base.substitution.ISubstitutionSource;
	import com.layerglue.lib.base.substitution.XMLSubstitutor;
	import com.layerglue.lib.base.substitution.sources.FlatXMLSubstitutionSource;
	import com.layerglue.lib.base.substitution.sources.MultiSubstitutionSource;

	import org.puremvc.as3.patterns.facade.Facade;

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
		[Embed(source="/../embedded-assets/embedded-assets.swf", mimeType="application/octet-stream")]
		private static var embeddedAssetsClass:Class;
		
		private var _regionalFontLoader:DisplayLoader;
		private var _assetsBasePath:String;
		
		public function InitialLoadManager()
		{
			super();
			
			_loader = FlashPreloadManager.getInstance().loadManager;
			
			//Add listeners
			_loader.addEventListener(Event.COMPLETE, loaderCompleteHandler, false, 0, true);
			FlashPreloadManager.getInstance().addEventListener(FlashPreloadManagerEvent.PRELOADER_VIEW_ANIMATION_COMPLETE, preloaderViewAnimCompleteHandler, false, 0, true);
			
			initialize();
		}
		
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
		
		private var _assetLibrary:AssetLibrary;
		
		public function assetLibrary():AssetLibrary
		{
			return _assetLibrary;
		}
		
		private var _loader:LoadManager;
		
		public function get loader():LoadManager
		{
			return _loader;
		}
		
		public function initialize():void
		{
			_assetsBasePath = FlashVars.getInstance().getValue("assetsBasePath", "flash-assets/");
			
			//Adding embedded assets
			_assetLibrary = new AssetLibrary();
			_assetLibrary.addEmbeddedSWF(embeddedAssetsClass);
			
			//Creating empty loader as url can only be defined after xml data has been deserialized.
			_regionalFontLoader = new DisplayLoader(new URLRequest());
			
			var locale:String = FlashVars.getInstance().getValue("locale");
			var localeConfigPath:String = _assetsBasePath+ "xml/configuration/locales/config_" + locale + ".xml";;
			var localeCopyPath:String = _assetsBasePath + "xml/copy/locales/copy_" + locale + ".xml";
			
			var globalConfigToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest(_assetsBasePath + "xml/configuration/config_global.xml")),
					globalConfigCompleteHandler,
					errorHandler,
					LoadProportionConstants.GLOBAL_CONFIG);
			
			var localeConfigToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest(localeConfigPath)),
					localeConfigCompleteHandler,
					errorHandler,
					LoadProportionConstants.LOCALE_CONFIG);
			
			var localeCopyToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest(localeCopyPath)),
					localeCopyCompleteHandler,
					errorHandler,
					LoadProportionConstants.LOCALE_COPY);
			
			var unsubstitutedStructureToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest(_assetsBasePath + "xml/structure/structure-unsubstituted.xml")),
					structureUnpopulatedCompleteHandler,
					errorHandler,
					LoadProportionConstants.UNSUBSTITUED_STRUCTURE);
			
			var regionalCompiledFontToken:LoadManagerToken = new LoadManagerToken(
					_regionalFontLoader,
					regionalCompiledFontCompleteHandler,
					errorHandler,
					LoadProportionConstants.REGIONAL_COMPILED_FONT);
			
			var runtimeAssetsToken:LoadManagerToken = new LoadManagerToken(
					new DisplayLoader(new URLRequest(_assetsBasePath + "runtime-assets.swf")),
					runtimeAssetsCompleteHandler,
					errorHandler,
					LoadProportionConstants.RUNTIME_ASSETS);
			
			_loader.addItem(globalConfigToken);						
			_loader.addItem(localeConfigToken);							
			_loader.addItem(localeCopyToken);							
			_loader.addItem(unsubstitutedStructureToken);							
			_loader.addItem(regionalCompiledFontToken);
			_loader.addItem(runtimeAssetsToken);
		}
		
		public function start():void
		{
			_loader.start();			
		}
		
		protected function setupData():void
		{
			var mergedConfigData:IKeyValuePairCollection = new MultiSubstitutionSource([_globalConfigSource, _localeConfigSource]);
			
			Facade.getInstance().registerProxy(new AssetLibraryProxy(_assetLibrary));
			Facade.getInstance().registerProxy(new ConfigProxy(mergedConfigData));
			Facade.getInstance().registerProxy(new CopyProxy(_localeCopySource));
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
			_localeCopySource = new FlatXMLSubstitutionSource((event.target as XmlLoader).typedData, "item");
			//_localeCopySource = new DelimitedValuesSubstitutionSource(event.target.data, "\n", ",", 1, 3, 0, "#");
			//_localeCopySource = new ExcelSubstitutionSource((event.target as XmlLoader).typedData, 2, 4, 1, "#");
			
			_loader.loadNext();
		}
		
		private function structureUnpopulatedCompleteHandler(event:Event):void
		{
			populateStructuralDataXML((event.target as XmlLoader).typedData);
			
			var region:String = _localeConfigSource.getValue("region");
			_regionalFontLoader.request.url = _assetsBasePath + "fonts/" + region + ".swf";
			
			_loader.loadNext();
		}
		
		private function regionalCompiledFontCompleteHandler(event:Event):void
		{
			LGStyleManager.getInstance().registerStyle((event.target as Loader).content as LGStyleCollection);
			
			_loader.loadNext();
		}
		
		private function runtimeAssetsCompleteHandler(event:Event):void
		{
			//Adding runtime assets
			_assetLibrary.addLoader(event.target as DisplayLoader, false);
			
			_loader.loadNext();
		}
		
		private function loaderCompleteHandler(event:Event):void
		{
			setupData();
		}
		
		private function errorHandler(event:Event):void
		{
			trace("Error loading file");
		}
		
		private function preloaderViewAnimCompleteHandler(event:FlashPreloadManagerEvent):void
		{
			//Currently setupData() is synchronous, so the animation completing
			//will always happen after it completes, but another check may be
			//needed if setupData is switched to asynchronous 
			FlashPreloadManager.getInstance().attachMainInstance();
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
			var structure:Site = deserializer.deserialize(xml);
			
			Facade.getInstance().registerProxy(new StructuralDataProxy(structure));
		}
		
	}
}