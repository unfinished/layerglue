package com.layerglue.lib.base.collections
{
	import com.layerglue.lib.base.models.vos.BusinessValueObject;
	import com.layerglue.lib.base.models.vos.IBusinessValueObject;
	import com.layerglue.lib.base.utils.ReflectionUtils;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	dynamic public class BusinessValueObjectCollection extends Array implements IBusinessValueObject, IEventDispatcher
	{
		private var _eventDispatcher:EventDispatcher;
		
		public function BusinessValueObjectCollection()
		{
			super();
			//pushRest(rest);
			_eventDispatcher = new EventDispatcher(this);
		}
		
		protected function pushRest(rest:Array):void
		{
			var o:IBusinessValueObject;
			for each(o in rest){
				push(o);
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
		
		public function getItemAtIndex(index:int):*
		{
			return this[index];
		}
		
		public function getItemById(id:String):IBusinessValueObject
		{
			var item:IBusinessValueObject;
			
			for each(item in this)
			{
				if(item.id == id)
				{
					return item;
				}
			}
			
			return null;
		}
		
		public function removeItemById(id:String):void
		{
			splice(getItemIndexById(id), 1);
		}
		
		public function getItemIndexById(id:String):int
		{
			var item:BusinessValueObject;
			var i:int;
			for(i=0 ; i<length ; i++)
			{
				item = this[i];
				if(item.id == id)
				{
					return i;
				}
			}
			
			return NaN;
		}
		
		public function removeAllItems():void
		{
			
			var item:BusinessValueObject;
			var i:int;
			for(i=0 ; i<length ; i++)
			{
				this[i] = null;
			}
			
			this.splice(0, length);
			
		}
		
		public function toString():String
		{
			return "[ " + ReflectionUtils.getClassName(this) + " ]";
		}
		
		// ---------- IEventDispatcher implementation -----
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void
		{
			_eventDispatcher.addEventListener(type, listener,useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return _eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return _eventDispatcher.willTrigger(type);
		}
		
		// ------------------------------------------------
	}
}