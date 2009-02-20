package com.layerglue.components
{
	import fl.core.UIComponent;
	
	import flash.display.DisplayObject;

	public class LGBox extends UIComponent
	{
		public function LGBox()
		{
			super();
			
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			var addedChild:DisplayObject = super.addChild(child);
			invalidate();
			return addedChild;
		}
		
	}
}