package com.layerglue.controls
{
	import com.layerglue.components.LGUIComponent;
	
	import flash.events.MouseEvent;

	public class BaseButton extends LGUIComponent
	{
		public function BaseButton()
		{
			super();
			
			buttonMode = true;
			mouseChildren = false;
			
			setPhase(ButtonPhase.UP);
			
			addEventListener(MouseEvent.ROLL_OVER,mouseEventHandler,false,0,true);
			addEventListener(MouseEvent.MOUSE_DOWN,mouseEventHandler,false,0,true);
			addEventListener(MouseEvent.MOUSE_UP,mouseEventHandler,false,0,true);
			addEventListener(MouseEvent.ROLL_OUT,mouseEventHandler,false,0,true);
		}
		
		protected var _selected:Boolean;
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
		}
		 
		protected var _phase:String;
		
		public function get phase():String
		{
			return _phase;
		}
		
		protected function setPhase(phase:String):void
		{
			_phase = phase;
		}
		
		protected function mouseEventHandler(event:MouseEvent):void
		{
			if (event.type == MouseEvent.MOUSE_DOWN)
			{
				setPhase(ButtonPhase.DOWN);
			}
			else if(event.type == MouseEvent.ROLL_OVER || event.type == MouseEvent.MOUSE_UP)
			{
				setPhase(ButtonPhase.OVER);
			}
			else if (event.type == MouseEvent.ROLL_OUT)
			{
				setPhase(ButtonPhase.UP);
			}
			
			invalidate();
		}
	}
}