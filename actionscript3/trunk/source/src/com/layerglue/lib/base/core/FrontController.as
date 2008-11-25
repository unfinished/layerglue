package com.layerglue.lib.base.core
{
	import com.layerglue.lib.base.commands.ICommand;
	import com.layerglue.lib.base.maps.AbstractRequestCommandMap;
	import com.layerglue.lib.base.requests.IRequest;
	import com.layerglue.lib.base.utils.ArrayUtils;
	
	/**
	 * A singleton class through which all requests are dispatched. When a request is dispatched,
	 * this class attempts to execute its matching command.
	 */
	public class FrontController extends Object
	{
		public function FrontController(requestCommandMaps:Array=null)
		{
			super();
			
			this.requestCommandMaps = requestCommandMaps;
		}
		 
		private static var _instance:FrontController;
		
		/**
		 * Creates the singleton instance of this class.
		 * 
		 * @param requestCommandMaps An array of maps to be used in connecting requests to commands.
		 */
		public static function initialize(requestCommandMaps:Array=null):FrontController
		{
			if(!_instance)
			{
				_instance = new FrontController(requestCommandMaps);
			}
			
			return _instance;
		}
		
		/**
		 * A reference to this singleton instance.
		 */
		public static function getInstance():FrontController
		{
			return initialize();
		}
		
		private var _requestCommandMaps:Array;
		
		/**
		 * A list of request command maps held by the connector
		 */
		public function get requestCommandMaps():Array
		{
			return _requestCommandMaps;
		}
		
		public function set requestCommandMaps(value:Array):void
		{
			_requestCommandMaps = value;
		}
		
		/**
		 * Adds the specified request command map
		 */
		public function addRequestCommandMap(map:AbstractRequestCommandMap):void
		{
			_requestCommandMaps.push(map);
		}
		
		/**
		 * Removes the specified request command map
		 */
		public function removeRequestCommandMap(map:AbstractRequestCommandMap):void
		{
			ArrayUtils.removeItem(_requestCommandMaps, map);
		}
		
		/**
		 * Removes all request command maps
		 */
		public function removeAllRequestCommandMaps():void
		{
			ArrayUtils.removeAllItems(_requestCommandMaps);
		}
		
		/**
		 * Executes the related command to the specified request if it exists.
		 */
		public function attemptExecution(map:AbstractRequestCommandMap, request:IRequest):Boolean
		{
			var commandClassReference:Class = map.getCommandClassReferenceByRequest(request);
		 	
			if(commandClassReference)
			{
				var command:ICommand = new commandClassReference();
				command.execute(request);
				return true;
			}
			
			return false;
		}
		
		/**
		 * A method to be used by requests to dispatch themselves via this singleton
		 */
		public function dispatchRequest(request:IRequest):void
		{
			var matchFound:Boolean = false;
			var map:AbstractRequestCommandMap;
			for each(map in requestCommandMaps)
			{
				if( attemptExecution(map, request) )
				{
					matchFound = true;
				}
			}
			
			if( !matchFound )
			{
				throw new Error("An IRequest was dispatched with no matching ICommand: " + request);
			}
		}
	}
}