package com.layerglue.components
{
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.events.ComponentEvent;
	
	import flash.display.DisplayObject;

	public class LGBox extends UIComponent
	{
		public function LGBox()
		{
			super();
			
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if (!(child is UIComponent))
			{
				throw new Error("Only a subclass of UIComponent can be added to a box: "+child);
			}
			child.addEventListener(ComponentEvent.RESIZE, onChildResize, false, 0, true);
			child.addEventListener(ComponentEvent.MOVE, onChildMove, false, 0, true);
			invalidate();
			return super.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			if (!(child is UIComponent))
			{
				throw new Error("Only a subclass of UIComponent can be added to a box: "+child);
			}
			child.addEventListener(ComponentEvent.RESIZE, onChildResize, false, 0, true);
			child.addEventListener(ComponentEvent.MOVE, onChildMove, false, 0, true);
			invalidate();
			return super.addChildAt(child, index);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			child.addEventListener(ComponentEvent.RESIZE, onChildResize, false);
			child.addEventListener(ComponentEvent.MOVE, onChildMove, false);
			invalidate();
			return super.removeChild(child);
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = getChildAt(index);
			child.addEventListener(ComponentEvent.RESIZE, onChildResize, false);
			child.addEventListener(ComponentEvent.MOVE, onChildMove, false);
			invalidate();
			return super.removeChildAt(index);
		}
		
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
		{
			invalidate();
			super.swapChildren(child1, child2);
		}
		
		override public function swapChildrenAt(index1:int, index2:int):void
		{
			invalidate();
			super.swapChildrenAt(index1, index2);
		}
		
		override public function setChildIndex(child:DisplayObject, index:int):void
		{
			invalidate();
			super.setChildIndex(child, index);
		}
		
		override protected function draw():void
		{
			if (isInvalid(InvalidationType.ALL))
			{
				positionChildren();
			}
			super.draw();
		}
		
		protected function positionChildren():void
		{
			if (numChildren == 0) 
			{
				_width = 0;
				return;
			}
			
			var i:int;
			var child:DisplayObject;
			var prevChild:DisplayObject;
			
			// Position first child
			child = getChildAt(0);
			child.x = 0;
			trace("position child 0, x="+child.x+", w="+child.width);
			
			for (i = 1; i < numChildren; i++)
			{
				// Position subsequent children
				child = getChildAt(i);
				prevChild = getChildAt(i-1);
				child.x = prevChild.x + prevChild.width;
				trace("position child "+i+", x="+child.x+", w="+child.width);
			}
			width = child.x + child.width;
			trace("box width = "+width);
		}
		
		// Ensures the layout routines are run if a child is resized
		protected function onChildResize(event:ComponentEvent):void
		{
			trace("box child has been resized");
			trace(UIComponent.inCallLaterPhase);
			invalidate();
			//validateNow();
		}
		
		// Ensures the layout routines are run if a child is moved
		// Strictly speaking a child cannot be moved inside a box,
		// so any attempt to change x/y will fail because the layout
		// routine will run and reposition everything automatically.
		protected function onChildMove(event:ComponentEvent):void
		{
			invalidate();
			//validateNow();
		}
	}
}