package com.layerglue.lib.base.views.flex.showHide
{
	import com.layerglue.lib.base.core.IDestroyable;
	import com.layerglue.lib.base.events.DestroyEvent;
	
	import mx.containers.Box;
	import mx.effects.Effect;
	
	[Event(name="showStart", type="com.layerglue.lib.base.events.ShowHideEvent")]
	[Event(name="showEnd", type="com.layerglue.lib.base.events.ShowHideEvent")]
	[Event(name="hideStart", type="com.layerglue.lib.base.events.ShowHideEvent")]
	[Event(name="hideEnd", type="com.layerglue.lib.base.events.ShowHideEvent")]
	
	public class ShowHideBox extends Box implements IShowHideable, IDestroyable
	{
		protected var _showHideTransitionUtil:ShowHideTransitionUtil;

		public function ShowHideBox()
		{
			super();
			_showHideTransitionUtil = new ShowHideTransitionUtil(this, false);
		}
		
		public function show(doImmediately:Boolean=false):void
		{
			_showHideTransitionUtil.show(doImmediately);
		}
		
		public function hide(doImmediately:Boolean=false, destroyAfterHideComplete:Boolean=false):void
		{
			_showHideTransitionUtil.hide(doImmediately, destroyAfterHideComplete);
		}
		
		public function getEffectForShowing():Effect
		{
			throw new Error("IShowHideable.getEffectForShowing() is not overriden in subclass");
		}
		
		public function getEffectForHiding():Effect
		{
			throw new Error("IShowHideable.getEffectForHiding() is not overriden in subclass");
		}
		
		public function get showHideState():String
		{
			return _showHideTransitionUtil.showHideState;
		}
		
		public function destroy():void
		{
			if(parent)
			{
				//trace('remove view: ' + this);
				parent.removeChild(this);
			}
			
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}
		
	}
}