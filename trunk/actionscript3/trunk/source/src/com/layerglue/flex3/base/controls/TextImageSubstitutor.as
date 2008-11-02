package com.layerglue.flex3.base.controls
{
	import com.layerglue.lib.base.utils.ImageSubstitutorUtils;
	
	import flash.display.Bitmap;
	import flash.geom.ColorTransform;
	import flash.text.TextFormatAlign;
	
	import mx.controls.Image;
	import mx.controls.Text;
	
	/**
	 * Fools a text field into displaying an image, rather than text.
	 * Used in localization where images are required, i.e. Arabic and Herbrew.
	 * 
	 * If the incoming text conforms to the rules in ImageSubstitutorUtils.isImageSubstitute()
	 * then instead of populating a text field it slips an image into the display list.
	 * The image loads a bitmap determined by the incoming text, and the dimensions are returned
	 * as part of textWidth and textHeight, so as to preserve API.
	 */
	public class TextImageSubstitutor extends Text
	{
		protected var _imageReplacement:Image;
		
		public function TextImageSubstitutor()
		{
			super();
			//this.opaqueBackground = 0xAAAAAA;
		}
		
		override public function set text(value:String):void
		{
			// check if incoming text is actually a bitmap reference, and if so
			// create an image
			if ( getBitmapFromRef(value) ) {
				createImage(value);
			} else {
				super.text = value;
			}
		}
					
		override protected function createChildren():void
		{
			super.createChildren();
		}
		
		override public function get textWidth():Number
	    {
	    	if (_imageReplacement) {
	    		return _imageReplacement.width + 2;
	    	} else {
	        	return super.textWidth;
	     	}
	    }
	    
	    override public function get textHeight():Number
	    {
	    	if (_imageReplacement) {
	    		return _imageReplacement.height + 2;
	    	} else {
	        	return super.textHeight;
	     	}
	    }
	    	    
	    protected function getBitmapFromRef(ref:String):Bitmap
	    {
	    	if (!ref) return null;
	    	if ( !ImageSubstitutorUtils.isImageSubstitute(ref) ) return null;
			
			// Create Bitmap from embedded style sheet image
			var styleClassRef:Class = getStyle(ImageSubstitutorUtils.convertToStyleName(ref)) as Class;
			if (styleClassRef == null) {
				trace('WARNING: No bitmap embedded for: '+ref);
				return null;	
			}
			return new styleClassRef();
	    }
		
		protected function createImage(ref:String):void
		{
			if (_imageReplacement) return;
			
			_imageReplacement = new Image();
			addChild(_imageReplacement);
			var bitmap:Bitmap = getBitmapFromRef(ref);
			_imageReplacement.source = bitmap;
			
			// Text comes from UIComponent, so exact dimensions need to be specified.
			// This is because there's no layout strategy, unlike Canvas
			_imageReplacement.width = bitmap.width;
			_imageReplacement.height = bitmap.height;
			width = _imageReplacement.width;
			height = _imageReplacement.height;
			
			//_imageReplacement.opaqueBackground = 0x009900;
			//trace('createImage: w/h='+this.width+'/'+this.height);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			//trace('updateDisplayList w/h='+this.width+'/'+this.height);
			
			/*
			graphics.clear();
			graphics.beginFill(0xff0000, 0.5);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
			*/
			
			// Aligns the image as if it was a piece of text
			if (_imageReplacement)
			{
				// emulate 2 pixel gutter at top of text field
				_imageReplacement.y = 2;
								
				switch (getStyle('textAlign'))
				{
					case TextFormatAlign.LEFT:
					{
						_imageReplacement.x = getStyle('paddingLeft') + 2;
					}
					case TextFormatAlign.RIGHT:
					{
						_imageReplacement.x = (width - _imageReplacement.width - 2) - getStyle('paddingRight');
					}
					case TextFormatAlign.CENTER:
					{
						_imageReplacement.x =  (( (this.width+getStyle('paddingLeft')+getStyle('paddingRight')) / 2) - (_imageReplacement.width / 2));
					}
				}
				
				// Tint the image using the text color specified in setStyle
				// this currently destroys any 8bit alpha and makes it 1bit
				// giving harsh edges to the transparent bitmap.
				var colorTrans:ColorTransform = new ColorTransform();
				colorTrans.color = getStyle('color');
				_imageReplacement.transform.colorTransform = colorTrans;
			}
		}
	}
}