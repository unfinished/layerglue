package com.layerglue.flex3.base.views.showHide
{
	import com.layerglue.lib.base.events.EventListener;
	import com.layerglue.lib.base.events.ShowHideEvent;
	
	import mx.effects.Effect;
	import mx.events.EffectEvent;
	
	public class ShowHideTransitionUtil
	{
		protected var _target:IShowHideable;
		protected var _destroyAfterHideComplete:Boolean = false;
		protected var _effect:Effect;
		protected var _effectListener:EventListener;
		protected var _eventsBubble:Boolean;
		
		// A show/hide control is always visible (shown) at the start
		protected var _state:String = ShowHideState.HIDDEN;
		
		public function ShowHideTransitionUtil(host:IShowHideable, eventsBubble:Boolean=false)
		{
			_target = host;
			_eventsBubble = eventsBubble;
		}
		
		public function show(doImmediately:Boolean=false):void
		{
			stopCurrentEffect();
			_state = ShowHideState.SHOWING;
			_effect = _target.getEffectForShowing();
			_effectListener = new EventListener(_effect, EffectEvent.EFFECT_END, showEndHandler);
			_effect.play();
			if (doImmediately)
			{
				_effect.end();
			}
		}
		
		public function hide(doImmediately:Boolean=false, destroyAfterHideComplete:Boolean=false):void
		{
			_destroyAfterHideComplete = destroyAfterHideComplete;
			stopCurrentEffect();
			_state = ShowHideState.HIDING;
			_effect = _target.getEffectForHiding();
			_effectListener = new EventListener(_effect, EffectEvent.EFFECT_END, hideEndHandler);
			_effect.play();
			if (doImmediately)
			{
				_effect.end();
			}
		}
		
		protected function showEndHandler(event:EffectEvent):void
		{
			_effectListener.destroy();
			_state = ShowHideState.SHOWN;
			// TODO: Should events bubble?
			_target.dispatchEvent(new ShowHideEvent(ShowHideEvent.SHOW_END, _eventsBubble));
		}
		
		protected function hideEndHandler(event:EffectEvent):void
		{
			_effectListener.destroy();
			_state = ShowHideState.HIDDEN;
			// TODO: Should events bubble?
			_target.dispatchEvent(new ShowHideEvent(ShowHideEvent.HIDE_END, _eventsBubble));
			if (_destroyAfterHideComplete)
			{
				_target.destroy();
			}
		}
		
		public function stopCurrentEffect():void
		{
			if (_effect)
			{
				_effectListener.destroy();
				_effect.stop();
				
				//TODO Put something in this util so that phase is stored so we can tell which of
				//of the events below to dispatch when.
				
				//_target.dispatchEvent(new ShowHideEvent(ShowHideEvent.SHOW_STOP, _eventsBubble));
				//_target.dispatchEvent(new ShowHideEvent(ShowHideEvent.HIDE_STOP, _eventsBubble));
			}
		}
		
		public function get showHideState():String
		{
			return _state;
		}
	}
}