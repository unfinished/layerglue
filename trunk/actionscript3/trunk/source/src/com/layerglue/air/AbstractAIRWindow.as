package com.layerglue.air
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * Abstract base-class for a pure Actionscript AIR window. You should create a sub-class
	 * of this to work with it. The object created by instantiating AbstractAIRWindow
	 * is not actually the window, but the main display object that's added to the window's stage.
	 * Bizarrely this means the window's contents is reponsible for creating the window it
	 * sits inside.
	 * 
	 * All visual elements can be added to this object and will appear inside the window.
	 * The window object can be retrieved by accessing the nativeWindow property.
	 * 
	 * @author LayerGlue
	 */
	public class AbstractAIRWindow extends Sprite
	{
		/**
		 * Creates a new instance of an AIR window. This should be sub-classed rather than
		 * instantiated directly. The initOptions should be set in the sub-class constructor
		 * and passed through as a paramter of super(). To display the window on the screen
		 * you must call open().
		 * 
		 * @param initOptions The options for the new NativeWindow
		 * @see open()
		 */
		public function AbstractAIRWindow(initOptions:NativeWindowInitOptions = null)
		{
			super();
			
			// The only time a newly constructed Sprite will ever have a stage is if it's been
			// used as the Document class of a Flash application. If this is the case we are
			// assuming the instance of this class is being used as the initialWindow.content
			// property of the AIR application. If so then stage will already contain a default
			// NativeWindow, and we will use that instead of creating a new one.
			// This catch is necessary when AbstractAIRApplication is used.
			if (stage)
			{
				_nativeWindow =  stage.nativeWindow;
			}
			else
			{
				initOptions = initOptions ? initOptions : new NativeWindowInitOptions();
				_nativeWindow = new NativeWindow(initOptions);
				_nativeWindow.stage.addChild(this);
			}
		}
		
		protected var _nativeWindow:NativeWindow;
		/**
		 * The native window object. NOTE: AbstractAIRWindow is the actual <em>contents</em> of
		 * the window, not the window itself. The window can be accessed via this property.
		 */
		public function get nativeWindow():NativeWindow
		{
			return _nativeWindow;
		}
		
		/**
		 * Opens the window and makes it active (brings it to foreground focus).
		 */
		public function open():void
		{
			nativeWindow.activate();
			nativeWindow.orderToFront();
		}
		
		/**
		 * Closes the window. This action is cancelable. If you listen for Event.CLOSING
		 * on the nativeWindow property you can call event.preventDefault() and the window
		 * will not close. This is useful to catch un-saved files, etc.
		 * 
		 * NOTE: If you wish to be able to catch Event.CLOSING you <em>must</em> use this method
		 * and not NativeWindow.close(), which doesn't fire the event and will close the window
		 * immediately.
		 */
		public function close():void
		{
			var event:Event = new Event(Event.CLOSING, false, true);
	    	nativeWindow.dispatchEvent(event);
	    	if ( !(event.isDefaultPrevented()) )
	    	{
	    		stage.nativeWindow.close();
	    		_nativeWindow = null;
	    		stage.removeChild(this);
	    	}
		}
	}
}