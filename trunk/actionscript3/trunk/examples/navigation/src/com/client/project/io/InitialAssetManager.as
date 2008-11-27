package com.client.project.io
{
	import com.client.project.model.ModelLocator;
	import com.layerglue.flex3.base.loaders.CSSStyleLoader;
	import com.layerglue.flex3.base.preloader.PreloadManager;
	import com.layerglue.lib.base.io.FlashVars;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
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
	public class InitialAssetManager extends EventDispatcher
	{
		//Defining properties to hold XML Substitutors
		private var _globalConfigSource:ISubstitutionSource;
		private var _localeConfigSource:ISubstitutionSource;
		private var _copySource:ISubstitutionSource;
		
		private var _regionalCSSLoader:CSSStyleLoader;
		
		public var structuralXML:XML;
		
		public function InitialAssetManager()
		{
			super();
			
			initialize();
		}
		
		/**
		 * A reference to the PreloadManager singleton's loadManager
		 */
		private function get loadManager():ProportionalLoadManager
		{
			return PreloadManager.getInstance().loadManager;
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
					0.0025);
			
			var localeConfigToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest("flash-assets/xml/configuration/locales/config_" + modelLocator.locale.code + ".xml")),
					localeConfigCompleteHandler,
					errorHandler,
					0.0025);
			
			var localeCopyToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest("flash-assets/xml/copy/locales/copy_" + modelLocator.locale.code + ".xml")),
					localeCopyCompleteHandler,
					errorHandler,
					0.0025);
			
			var unsubstitutedStructureToken:LoadManagerToken = new LoadManagerToken(
					new XmlLoader(new URLRequest("flash-assets/xml/structure/structure-unsubstituted.xml")),
					structureUnpopulatedCompleteHandler,
					errorHandler,
					0.0025);
			
			var regionalCSSToken:LoadManagerToken = new LoadManagerToken(
					_regionalCSSLoader,
					regionalCompiledCSSCompleteHandler,
					errorHandler,
					0.39);
			
			loadManager.addItem(globalConfigToken);						
			loadManager.addItem(localeConfigToken);							
			loadManager.addItem(localeCopyToken);							
			loadManager.addItem(unsubstitutedStructureToken);							
			loadManager.addItem(regionalCSSToken);
		}
		
		public function start():void
		{
			loadManager.start();
		}
		
		private function globalConfigCompleteHandler(event:Event):void
		{
			_globalConfigSource = new FlatXMLSubstitutionSource((event.target as XmlLoader).typedData, "item");
			loadManager.loadNext();
		}
		
		private function localeConfigCompleteHandler(event:Event):void
		{
			_localeConfigSource = new FlatXMLSubstitutionSource((event.target as XmlLoader).typedData, "item");
			loadManager.loadNext();
		}
		
		private function localeCopyCompleteHandler(event:Event):void
		{
			_copySource = new FlatXMLSubstitutionSource((event.target as XmlLoader).typedData, "item");
			loadManager.loadNext();
		}
		
		private function structureUnpopulatedCompleteHandler(event:Event):void
		{
			populateStructuralDataXML((event.target as XmlLoader).typedData);
			
			var region:String = _localeConfigSource.getValueByReference("region");
			
			//Simulate availability of config data by setting the regional css path 
			_regionalCSSLoader.request.url = "flash-assets/compiled-css/regions/" + region + ".swf?cacheBuster=" + Math.random();
			
			loadManager.loadNext();
		}
		
		private function regionalCompiledCSSCompleteHandler(event:Event):void
		{
			loadManager.loadNext();
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
			structuralXML = substitutor.process(xml, source);
			
			var missingSourceKeys:Array = substitutor.getMissingSourceKeys(xml, source);
			
			if(missingSourceKeys.length > 0)
			{
				trace("********** XML SUBSTITUION KEYS ARE MISSING **********");
				var key:String;
				for each(key in missingSourceKeys)
				{
					trace(key)
				}
				trace("******************************************************");
			}
			else
			{
				//trace("********** ALL XML SUBSTITUION KEYS ARE PRESENT **********");
			}
			
		}
		
	}
}