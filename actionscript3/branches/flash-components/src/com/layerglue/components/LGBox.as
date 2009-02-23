package com.layerglue.components
{
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.events.ComponentEvent;
	
	import flash.display.DisplayObject;
	
	/**
	 * LGBox acts as a container that lays out children sequentially. The direction can be either
	 * horizontally or vertically and the children will be spaced evenly. LGBox will only accept
	 * instances of UIComponent (or subclasses thereof). It can be used like a standard display
	 * container, using addChild and removeChild to manage the children.
	 */
	public class LGBox extends UIComponent
	{
		public static var HORIZONTAL:String = "horizontal";
		public static var VERTICAL:String = "vertical";
		
		/**
		 * Creates a new LGBox component with a specific direction. The direction can be either
		 * LGBox.HORIZONTAL and LGBox.VERTICAL.
		 * 
		 * @param direction Direction the children are layed out inside the box
		 * @param gap The pixel gap between each child inside the box.
		 */
		public function LGBox(direction:String, gap:Number = 0)
		{
			super();
			this.direction = direction;
			this.gap = gap;
		}
		
		protected var _direction:String;
		/**
		 * The direction children are layed out inside the box. The permitted direction types are
		 * LGBox.HORIZONTAL and LGBox.VERTICAL.
		 */
		public function get direction():String
		{
			return _direction;
		}
		
		public function set direction(value:String):void
		{
			if (value != HORIZONTAL && value != VERTICAL)
			{
				throw new Error("Invalid direction type. Only LGBox.HORIZONTAL and LGBox.VERTICAL are permitted.");
			}
			_direction = value;
			invalidate(InvalidationType.SIZE);
		}
		
		protected var _gap:Number = 0;
		/**
		 * The gap between each child of the box. This applies to horizontal or vertical direction,
		 * depending on which is currently used.
		 */
		public function get gap():Number
		{
			return _gap;
		}
		
		public function set gap(value:Number):void
		{
			_gap = value;
			invalidate(InvalidationType.SIZE);
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if (!(child is UIComponent))
			{
				throw new Error("Only a subclass of UIComponent can be added to a box: "+child);
			}
			child.addEventListener(ComponentEvent.MOVE, onChildMove, false, 0, true);
			invalidate(InvalidationType.ALL);
			return super.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			if (!(child is UIComponent))
			{
				throw new Error("Only a subclass of UIComponent can be added to a box: "+child);
			}
			child.addEventListener(ComponentEvent.MOVE, onChildMove, false, 0, true);
			invalidate(InvalidationType.ALL);
			return super.addChildAt(child, index);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			child.addEventListener(ComponentEvent.MOVE, onChildMove, false);
			invalidate(InvalidationType.ALL);
			return super.removeChild(child);
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = getChildAt(index);
			child.addEventListener(ComponentEvent.MOVE, onChildMove, false);
			invalidate(InvalidationType.ALL);
			return super.removeChildAt(index);
		}
		
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
		{
			invalidate(InvalidationType.ALL);
			super.swapChildren(child1, child2);
		}
		
		override public function swapChildrenAt(index1:int, index2:int):void
		{
			invalidate(InvalidationType.ALL);
			super.swapChildrenAt(index1, index2);
		}
		
		override public function setChildIndex(child:DisplayObject, index:int):void
		{
			invalidate(InvalidationType.ALL);
			super.setChildIndex(child, index);
		}
		
		override protected function draw():void
		{
			// We must validate and run all the children's draw routines BEFORE we run the
			// positioning routine. This ensures every child is the correct size and the
			// box can lay out everything accordingly.
			var i:int;
			var child:UIComponent;
			for (i = 0; i < numChildren; i++)
			{
				child = getChildAt(i) as UIComponent;
				child.validateNow();
			}
			
			if (isInvalid(InvalidationType.SIZE))
			{
				positionChildren();
			}
			super.draw();
		}
		
		protected function positionChildren():void
		{
			if (numChildren == 0) 
			{
				// If there are no children then abort this routine
				width = 0;
				height = 0;
				return;
			}
			
			var i:int;
			var child:DisplayObject;
			var prevChild:DisplayObject;
			
			// Position first child
			child = getChildAt(0);
			child.x = 0;
			child.y = 0;
			var maxWidth:Number = child.x + child.width;
			var maxHeight:Number = child.y + child.height;
			
			for (i = 1; i < numChildren; i++)
			{
				// Position subsequent children
				child = getChildAt(i);
				prevChild = getChildAt(i-1);
				if (direction == HORIZONTAL)
				{
					child.x = prevChild.x + prevChild.width + gap;
					child.y = 0;
				}
				else
				{
					child.x = 0;
					child.y = prevChild.y + prevChild.height + gap;
				}
				
				// Calculate max and min widths gathered so far
				maxWidth = Math.max(maxWidth, child.x + child.width);
				maxHeight = Math.max(maxHeight, child.y + child.height);
			}
			
			// Apply max children dimensions to this component
			width = maxWidth;
			height = maxHeight;
			
		}
		
		// Ensures the layout routines are run if a child is moved
		// Strictly speaking a child cannot be moved inside a box,
		// so any attempt to change x/y will fail because the layout
		// routine will run and reposition everything automatically.
		protected function onChildMove(event:ComponentEvent):void
		{
			// invalidate will not do anything when onChildMove is called as a 
			//invalidate();
		}
	}
}