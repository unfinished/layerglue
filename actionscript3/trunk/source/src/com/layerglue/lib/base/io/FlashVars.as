package com.layerglue.lib.base.io
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * <p>FlashVars provides unified singleton access to the flashvars in the HTML embed code of the
	 * swf.</p>
	 * <p>This class should be initialized as soon as possible in the startup of the
	 * application/movie to allow access to FlashVars. In Flex this should be done in the preloader.
	 * </p>
	 * 
	 * @see CustomPreloader
	 */
	public class FlashVars extends EventDispatcher
	{
		private static var _instance:FlashVars;
		
		public function FlashVars(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * Initializes the singleton instance of FlashVars
		 */
		public static function initialize(root:DisplayObject=null):FlashVars
		{
			if(!_instance)
			{
				_instance = new FlashVars();
			}
			
			if(root)
			{
				_instance.root = root;
			}
			
			return _instance;
		}
		
		/**
		 * Returns a singleton instance of the FlashVars object
		 */
		public static function getInstance():FlashVars
		{
			return initialize();
		}
		
		private var _root:DisplayObject;
		/**
		 * The root of the movie/application
		 */
		public function get root():DisplayObject
		{
			return _root;
		}
		
		public function set root(value:DisplayObject):void
		{
			_root = value;
		}
		
		/**
		 * Whether or not flashvars can be accessed
		 */
		public function active():Boolean
		{
			return !!_root;
		}
		
		/**
		 * Returns the corresponding flashvar or a default value
		 */
		public function getValue(key:String, defaultValue:String=null):String
		{
			if(_root)
			{
				var flashVarValue:String = _root.loaderInfo.parameters[key];
				
				return flashVarValue ? flashVarValue : defaultValue;
			}
			else
			{
				throw new Error("Tried to access swf root value before it has been registered with FlashVars singleton");
			}
		}	
		
	}
}