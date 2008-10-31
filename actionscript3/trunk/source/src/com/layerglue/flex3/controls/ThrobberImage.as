package com.layerglue.flex3.controls
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import mx.core.mx_internal;
	
	use namespace mx_internal;

	public class ThrobberImage extends SmoothImage
	{
		protected var _throbberMeasurementsUsed:Boolean;
		protected var _throbber:Throbber;
		
		public function ThrobberImage()
		{
			super();
			
			addEventListener(IOErrorEvent.IO_ERROR, ioErrorEventHandler, false, 0, true);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			// TODO: Throbber doesn't appear again if the Image.source property is changed
			// and a new image is loaded
			_throbber = new Throbber();
			addChild(_throbber);
			
			// If no width/height is set on the image then it will take the size of the
			// throbber until the image file is loaded
			if (width == 0 && height == 0)
			{
				width = _throbber.width;
				height = _throbber.height;
				_throbberMeasurementsUsed = true;
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			_throbber.x = (width / 2) - (_throbber.width / 2);
			_throbber.y = (height / 2) - (_throbber.height / 2);
		}
		
		override mx_internal function contentLoaderInfo_completeEventHandler(event:Event):void
	    {
	    	// Clears the throbber sizing so that the newly loaded image will be used
	    	// to size the component
	    	if (_throbberMeasurementsUsed)
	    	{
		    	width = NaN;
		    	height = NaN;
		    	_throbberMeasurementsUsed = false;
	    	}
	    	super.contentLoaderInfo_completeEventHandler(event);
	    	
			if (contains(_throbber))
			{
				removeChild(_throbber);
			}
	    }
	    
	    protected function ioErrorEventHandler(event:IOErrorEvent):void
	    {
			if (contains(_throbber))
			{
				removeChild(_throbber);
			}
	    }
	}
}