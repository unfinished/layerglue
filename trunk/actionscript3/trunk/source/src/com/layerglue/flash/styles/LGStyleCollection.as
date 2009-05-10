package com.layerglue.flash.styles
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	public class LGStyleCollection extends Sprite
	{
		/*
		public static function initializeCollection(collection:Class):void
		{
			new collection();
		}
		*/
		
		public function LGStyleCollection()
		{
			_assets = new Dictionary();
			
			registerFonts();
			defineStyles();
			defineAssets();
		}
		
		protected function registerFonts():void
		{
			
		}
		
		protected function defineStyles():void
		{
			
		}
		
		protected function defineAssets():void
		{
			
		}
		
		private var _assets:Dictionary;
		
		public function getAssetById(id:String):*
		{
			return _assets[id];
		}
		
		public function addAsset(id:String, asset:Class):void
		{
			_assets[id] = asset;
		}
		
		/*
		public function removeAsset(id:String, asset:Class):Boolean
		{
			if(containsAsset(id))
			{
				delete _assets[id];
				return true;
			}
			
			return false;
		}
		
		public function containsAsset(id:String):Boolean
		{
			return !!_assets[id];
		}
		*/
	}
}