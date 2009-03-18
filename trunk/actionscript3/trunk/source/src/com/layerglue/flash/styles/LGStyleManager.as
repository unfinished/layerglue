package com.layerglue.flash.styles
{
	public class LGStyleManager
	{
		private static var _instance:LGStyleManager;
		private static var _initialized:Boolean;
		
		/**
		 * 
		 * <strong>Example:</strong>
		 * 
		 * //Extracting image assets
		 * var classRef:Class = LGStyleManager.getInstance().getAsset("testImage") as Class;
		 * var im:DisplayObject = addChild(new classRef());
		 */
		public function LGStyleManager()
		{
			if (_instance != null)
			{
				throw new Error("Singleton instantiation");
			}
			
			_instance = this;
			
			_styleCollections = [];
		}
		
		private var _styleCollections:Array;
		
		public function registerStyle(styleCollection:LGStyleCollection):void
		{
			_styleCollections.push(styleCollection);
		}
		
		public static function getInstance():LGStyleManager
		{
			if (_instance == null)
			{
				_instance = new LGStyleManager();
				
			}
			return _instance;
		}
		
		public function getAsset(id:String):*
		{
			for(var i:int = _styleCollections.length-1 ; i>=0 ; i--)
			{
				var asset:* = (_styleCollections[i] as LGStyleCollection).getAssetById(id);
				
				if(asset)
				{
					return asset;
				}
			}
		}
		
	}
}