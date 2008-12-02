package com.client.project.view.controls
{
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.core.UIComponent;

	public class Thumbnail extends Canvas
	{
		public var image:Image;
		
		protected var _selectionBorder:UIComponent;
		
		public function Thumbnail()
		{
			super();
			
			buttonMode = true;
		}
		
		private var _source:String;
		private var _sourceChanged:Boolean = false;
		
		public function get source():String
		{
			return _source;
		}
		
		public function set source(value:String):void
		{
			_source = value;
			_sourceChanged = true;
			invalidateProperties();
		}
		
		private var _selected:Boolean;
		private var _selectedChanged:Boolean = false;
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			_selectedChanged = true;
			
			trace("set selected: " + _selected + ", image id: "+getRepeaterItem().id);
			invalidateDisplayList();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			image = new Image();
			addChild(image);
			
			_selectionBorder = new UIComponent();
			_selectionBorder.alpha = 0;
			addChild(_selectionBorder);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (_sourceChanged)
			{
				image.source = _source;
				_sourceChanged = false;
			}
			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			_selectionBorder.graphics.clear();
			_selectionBorder.graphics.lineStyle(2, 0xFF0000, 1);
			_selectionBorder.graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			
			if (_selectedChanged)
			{
				_selectionBorder.alpha = selected ? .7 : 0;
				_selectedChanged = false;
			}
		}
		
	}
}