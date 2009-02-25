package com.layerglue.components
{
	import fl.core.UIComponent;
	import fl.managers.StyleManager;
	
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class LGUIComponent extends UIComponent
	{
		private static var defaultStyles:Object = { }
		
		protected var inCallLaterPhase2:Boolean;
		
		public function LGUIComponent()
		{
			super();
		}
		
		public static function getStyleDefinition():Object
		{ 
			return UIComponent.mergeStyles(UIComponent.getStyleDefinition(), defaultStyles);
		}
		
		// Properly implement cascading styles without the need to set up defaultStyles on each class.
		override protected function getStyleValue(name:String):Object
		{
			var instanceStyle:Object = instanceStyles[name];
			if (instanceStyle == null)
			{
				var componentStyle:Object = StyleManager.getComponentStyle(this, name);
				if (componentStyle == null)
				{
					var globalStyle:Object = sharedStyles[name];
					return globalStyle;
				}
				else
				{
					return componentStyle;
				}
			}
			else
			{
				return instanceStyle;
			}
			return null;
		}
		
		override protected function callLater(fn:Function):void {
			if (inCallLaterPhase2) {
				//trace("-Can't invalidate because already in invalidation phase: ";
				return;
			}
			//trace("invalidation OK: ");
			
			callLaterMethods[fn] = true;
			if (stage != null) {
				stage.addEventListener(Event.RENDER,callLaterDispatcher2,false,0,true);
				stage.invalidate();				
			} else {
				addEventListener(Event.ADDED_TO_STAGE,callLaterDispatcher2,false,0,true);
			}
		}
		
		protected function callLaterDispatcher2(event:Event):void {
			if (event.type == Event.ADDED_TO_STAGE) {
				removeEventListener(Event.ADDED_TO_STAGE,callLaterDispatcher2);
				// now we can listen for render event:
				stage.addEventListener(Event.RENDER,callLaterDispatcher2,false,0,true);
				stage.invalidate();
				
				return;
			} else {
				event.target.removeEventListener(Event.RENDER,callLaterDispatcher2);
				if (stage == null) {
					// received render, but the stage is not available, so we will listen for addedToStage again:
					addEventListener(Event.ADDED_TO_STAGE,callLaterDispatcher2,false,0,true);
					return;
				}
			}

			inCallLaterPhase2 = true;
			
			var methods:Dictionary = callLaterMethods;
			for (var method:Object in methods) {
				method();
				delete(methods[method]);
			}
			inCallLaterPhase2 = false;
		}
		
	}
}