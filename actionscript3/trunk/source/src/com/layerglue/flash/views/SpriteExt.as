package com.layerglue.flash.views
{
	import com.layerglue.lib.base.core.IDestroyable;
	import com.layerglue.lib.base.events.DestroyEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Jamie Copeland
	 */
	public class SpriteExt extends Sprite implements IDestroyable
	{
		
		public function SpriteExt()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
		}
		
		protected var _width:Number;
		
		override public function get width():Number
		{
			return isNaN(_width) ? super.width : _width;
		}
		
		override public function set width(value:Number):void
		{
			_width = value;
			invalidate();
		}
		
		public function setWidth(value:Number, dontInvalidate:Boolean=false):void
		{
			_width = value;
			
			if(!dontInvalidate)
			{
				invalidate();
			}
		}
		
		protected var _height:Number;
		
		override public function get height():Number
		{
			return isNaN(_height) ? super.height : _height;
		}
		
		override public function set height(value:Number):void
		{
			setHeight(value);
		}
		
		public function setHeight(value:Number, dontInvalidate:Boolean=false):void
		{
			_height = value;
			
			if(!dontInvalidate)
			{
				invalidate();
			}
		}
		
		protected var _childrenCreated:Boolean;
		
		public function get childrenCreated():Boolean
		{
			return _childrenCreated;
		}
		
		protected function createChildren():void
		{
		}

		protected function updateDisplayList():void
		{	
		}
		
		public function invalidate():void
		{
			if (_childrenCreated) updateDisplayList();
		}
		
		public function move(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function setSize(width:Number, height:Number, dontInvalidate:Boolean=false):void
		{
			setWidth(width, dontInvalidate);
			setHeight(height, dontInvalidate);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false);
			
			createChildren();
			_childrenCreated = true;
			invalidate();
		}
		
		public function destroy():void
		{
			if(parent)
			{
				parent.removeChild(this);
			}
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}
	}
	
}