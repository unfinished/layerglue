package com.layerglue.lib.base.collections.strategies 
{
	import flash.utils.Dictionary;

	/**
	 * @author Jamie Copeland
	 */
	public class DictionaryStrategy extends Object implements IDictionaryStrategy
	{
		public function DictionaryStrategy(keyPropertyName:String="id")
		{
			super();
			
			_keyPropertyName = keyPropertyName;
			_type = Dictionary;
		}
		
		private var _type:Class;
		/**
		 * @inheritDoc
		 */
		public function get type():Class
		{
			return _type;
		}
		
		public function set type(value:Class):void
		{
			_type = value;
		}
		
		protected var _keyPropertyName:String;
		
		public function get keyPropertyName():String
		{
			return _keyPropertyName;
		}
		
		public function set keyPropertyName(value:String):void
		{
			_keyPropertyName = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addItem(collection:Object, item:*):void
		{
			collection[item[keyPropertyName]] = item;	
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItem(collection:Object, item:*):*
		{
			return collection[item[keyPropertyName]] = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getItem(collection:Object, id:*):*
		{
			return collection[id];
		}
	}
}
