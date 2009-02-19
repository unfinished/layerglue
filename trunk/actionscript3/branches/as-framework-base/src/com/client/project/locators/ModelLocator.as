package com.client.project.locators
{
	import com.layerglue.lib.base.collections.HashMap;
	import com.layerglue.lib.base.localisation.Locale;
	
	[Bindable]
	public class ModelLocator
	{
		private static var _instance:ModelLocator;
		
		//public var structure:StructureRoot;
		public var locale:Locale;
		public var config:HashMap;
		
		public function ModelLocator()
		{
			if (_instance != null)
			{
				throw new Error("Singleton instantiation");
			}
			_instance = this;
		}
		
		public static function getInstance():ModelLocator
		{
			if (_instance == null)
			{
				_instance = new ModelLocator();
			}
			return _instance;
		}
	}
}