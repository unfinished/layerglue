package com.layerglue.lib.base.models.vos
{
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class BusinessValueObject extends EventDispatcher implements IBusinessValueObject
	{
		public function BusinessValueObject(id:String=null)
		{
			super();
			
			if(id)
			{
				this.id = id;
			}
			
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