package com.layerglue.lib.base.maps
{
	import com.layerglue.lib.base.collections.HashMap;
	import com.layerglue.lib.base.command.requests.IRequest;
	import com.layerglue.lib.base.utils.ReflectionUtils;

	/**
	 * A class that performs the basic functionality to map requests to commands. Subclasses of this
	 * should use the initialize method to set up the mappings.
	 */
	public class FrontControllerMap extends Object
	{
		private var _map:HashMap;
		
		public function FrontControllerMap()
		{
			super();
			
			_map = new HashMap();
			
			initialize();
		}
		
		/**
		 * Adds a request-command mapping.
		 */
		public function addMapping(requestClassReference:Class, commandClassReference:Class):void
		{
			_map.putValue(requestClassReference, commandClassReference);
		}
		
		/**
		 * Removes a request-command mapping if it exists.
		 */
		public function removeMapping(requestClassReference:Class):void
		{
			_map.removeValue(requestClassReference);
		}
		
		/**
		 * Removes all request-command mappings.
		 */
		public function removeAllMappings():void
		{
			_map.clear();
		}
		
		/**
		 * Returns the command class mapped to the specified request class
		 */
		public function getCommandClassByRequestClass(requestClass:Class):Class
		{
			return _map.getValue(requestClass);
		}
		
		/**
		 * Returns the command class mapped to the class reference of the specified request
		 */
		public function getCommandClassReferenceByRequest(request:IRequest):Class
		{
			return getCommandClassByRequestClass(ReflectionUtils.getClassReference(request));
		}
		
		/**
		 * Returns the number of mappings
		 */
		public function size():int
		{
			return _map.size();
		}
		
		/**
		 * To be used in subclasses for adding mappings:
		 * 
		 * <code>
		 * 
		 * addMapping(NavigationRequest, NavigationCommand);
		 * addMapping(ValidateUserInputRequest, ValidateUserInputCommand);
		 * 
		 * </code>
		 */
		protected function initialize():void
		{
		}
	}
}