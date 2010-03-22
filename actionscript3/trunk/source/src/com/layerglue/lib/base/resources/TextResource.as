package com.layerglue.lib.base.resources 
{

	/**
	 * @author Jamie Copeland
	 */
	public class TextResource extends Object implements IResourceItem 
	{
		public function TextResource()
		{
			super();
		}
		
		private var _id:String;
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
	}
}
