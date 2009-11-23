package com.client.project.preloader
{
	import com.layerglue.flash.preloader.FlashPreloadManager;
	import com.layerglue.lib.base.events.PreloadManagerEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import com.hydrotik.go.HydroTween;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import fl.motion.easing.Quadratic;
	import com.layerglue.flash.views.SpriteExt;
	import org.goasap.interfaces.IPlayable;
	import com.layerglue.lib.base.events.PreloaderViewEvent;

	public class PreloaderView extends SpriteExt
	{
		private static const LOADER_POLL_DURATION:Number = 500;
		private static const TWEEN_DURATION:Number = 500;
		
		private var _loaderPollTimer:Timer;
		private var _loadBarContainer:Sprite;
		private var _loadBarBackground:Sprite;
		private var _loadBar:Sprite;
		
		public function PreloaderView(preloadManager:FlashPreloadManager)
		{
			super();
			
			_preloadManager = preloadManager;
			
			_preloadManager.addEventListener(ProgressEvent.PROGRESS, loadChangeHandler);
			
			_loaderPollTimer = new Timer(LOADER_POLL_DURATION);
			_loaderPollTimer.addEventListener(TimerEvent.TIMER, loaderPollTimerHandler, false, 0, true);
			_loaderPollTimer.start();
		}
		
		private var _preloadManager:FlashPreloadManager;
		
		public function get preloadManager():FlashPreloadManager
		{
			return _preloadManager;
		}
		
		public function set preloadManager(value:FlashPreloadManager):void
		{
			_preloadManager = value;
		}
		
		protected function get amountLoaded():Number
		{
			return _preloadManager.loadManager.currentValue / _preloadManager.loadManager.totalValue;
		}
		
		private function loadChangeHandler(event:Event):void
		{
			//draw();
		}
		
		override protected function createChildren():void
		{
			_loadBarContainer = new Sprite();
			addChild(_loadBarContainer);
			
			_loadBarBackground = new Sprite();
			_loadBarContainer.addChild(_loadBarBackground);
			
			_loadBar = new Sprite();
			_loadBarContainer.addChild(_loadBar);
			
			var fixedWidth:Number = 200;
			var fixedHeight:Number = 20;
			
			//Draw background
			_loadBarBackground.graphics.beginFill(0x333333);
			_loadBarBackground.graphics.drawRect(0, 0, fixedWidth, fixedHeight);
			_loadBarBackground.graphics.endFill();
			
			//Draw bar
			_loadBar.graphics.beginFill(0x666666);
			_loadBar.graphics.drawRect(0, 0, fixedWidth, fixedHeight);
			_loadBar.graphics.endFill();
			
			_loadBar.scaleX = 0;
		}
		
		override protected function draw():void
		{
			if(childrenCreated)
			{
				_loadBarContainer.x = stage.stageWidth/2 - _loadBarContainer.width/2;
				_loadBarContainer.y = stage.stageHeight/2 - _loadBarContainer.height/2;
				
				triggerPoll();
			}
		}
		
		private function triggerPoll():void
		{
			tweenToValue(amountLoaded);
		}
		
		private var _progressTween:IPlayable;
		
		private function tweenToValue(value:Number):void
		{
			//Always make sure the tween is stopped before it is restarted
			if(_progressTween)
			{
				_progressTween.stop();
			}
			
			var completeHandler:Function;
			
			if(value >= 1)
			{
				//If we are fully loaded stop polling
				stopLoaderPollTimer();
				completeHandler = animationCompleteHandler;
			}
			
			_progressTween = HydroTween.go(_loadBar, {scaleX:value}, TWEEN_DURATION/1000, 0, Quadratic.easeOut, completeHandler);
			_progressTween.start();
		}
		
		private function stopLoaderPollTimer():void
		{
			if(_loaderPollTimer)
			{
				_loaderPollTimer.stop();
			}
		}
		
		private function loaderPollTimerHandler(event:TimerEvent):void
		{
			triggerPoll();
		}
		
		protected function animationCompleteHandler():void
		{
			dispatchEvent(new PreloaderViewEvent(PreloaderViewEvent.ANIMATION_COMPLETE, true, true));
		}
		
	}
}