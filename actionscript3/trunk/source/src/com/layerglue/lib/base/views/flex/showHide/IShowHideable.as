package com.layerglue.lib.base.views.flex.showHide
{
	import com.layerglue.lib.base.core.IDestroyable;
	
	import flash.events.IEventDispatcher;
	
	import mx.effects.Effect;
	
	public interface IShowHideable extends IDestroyable, IEventDispatcher
	{
		function getEffectForShowing():Effect;
		function getEffectForHiding():Effect;
		function show(doImmediately:Boolean=false):void;
		function hide(doImmediately:Boolean=false, destroyAfterHideComplete:Boolean=false):void;
		function get showHideState():String;
	}
}