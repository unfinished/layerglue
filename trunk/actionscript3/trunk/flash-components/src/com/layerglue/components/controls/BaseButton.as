package com.layerglue.components.controls
{
	import com.layerglue.components.LGUIComponent;
	import com.layerglue.components.constants.ButtonInvalidationType;
	import com.layerglue.components.constants.ButtonPhase;
	
	import flash.events.MouseEvent;

	public class BaseButton extends LGUIComponent
	{
		public function BaseButton()
		{
			super();
			
			buttonMode = true;
			mouseChildren = false;
			enabled = true;
			
			setPhase(ButtonPhase.UP);
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
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			
			if (value == true)
			{
				attachListeners();
				useHandCursor = true;
			}
			else
			{
				removeListeners();
				useHandCursor = false;
			}
		}
		 
		protected var _phase:String;
		
		public function get phase():String
		{
			return _phase;
		}
		
		protected function setPhase(phase:String):void
		{
			_phase = phase;
			invalidate(ButtonInvalidationType.PHASE_CHANGE);
		}
		
		protected function mouseEventHandler(event:MouseEvent):void
		{
			if (event.type == MouseEvent.MOUSE_DOWN)
			{
				setPhase(ButtonPhase.DOWN);
			}
			else if(event.type == MouseEvent.ROLL_OVER || event.type == MouseEvent.MOUSE_UP || event.type == MouseEvent.MOUSE_OVER)
			{
				setPhase(ButtonPhase.OVER);
			}
			else if (event.type == MouseEvent.ROLL_OUT || event.type == MouseEvent.MOUSE_OUT)
			{
				setPhase(ButtonPhase.UP);
			}
		}
		
		protected function attachListeners():void
		{
			addEventListener(MouseEvent.ROLL_OVER,mouseEventHandler,false,0,true);
			addEventListener(MouseEvent.MOUSE_DOWN,mouseEventHandler,false,0,true);
			addEventListener(MouseEvent.MOUSE_UP,mouseEventHandler,false,0,true);
			addEventListener(MouseEvent.ROLL_OUT,mouseEventHandler,false,0,true);
		}
		
		protected function removeListeners():void
		{
			removeEventListener(MouseEvent.ROLL_OVER,mouseEventHandler,false);
			removeEventListener(MouseEvent.MOUSE_DOWN,mouseEventHandler,false);
			removeEventListener(MouseEvent.MOUSE_UP,mouseEventHandler,false);
			removeEventListener(MouseEvent.ROLL_OUT,mouseEventHandler,false);
		}
	}
}