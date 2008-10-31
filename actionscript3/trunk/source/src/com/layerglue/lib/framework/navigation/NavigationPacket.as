package com.layerglue.lib.framework.navigation
{
	import com.layerglue.lib.base.navigation.QueryString;
	
	import flash.events.EventDispatcher;
	
	/**
	 * A class representing a uri internal to the application that will inform the controllers and
	 * structural data on how to behave. 
	 */
	public class NavigationPacket extends EventDispatcher
	{
		public function NavigationPacket(uri:String)
		{
			super();
			
			setUri(uri)
		}
		
		private var _query:QueryString;
		
		/**
		 * Returns an instance of the QueryString class representing the query portion of the uri
		 * string. E.g. ?locale=en-gb&userID=123456 
		 */
		public function get query():QueryString
		{
			return _query;
		}
		
		/**
		 * A protected method to set the query string
		 */
		protected function setQuery(query:QueryString):void
		{
			_query = query;
		}
		
		/**
		 * An array of strings representing the address portion of the full uri string split at the
		 * forward slash character.
		 */
		private var _uriNodeStrings:Array;
		
		/**
		 * Sets the uri represented by this packet instance.
		 */
		protected function setUri(uri:String):void
		{
			_uri = uri;
			
			var querySplit:Array = _uri.split("?");
			
			var addressPortion:String = querySplit[0];
			var queryPortion:String = querySplit[1];
			
			_uriNodeStrings = addressPortion.split("/");
			
			//Only try to create and set the query if there is any query data in the url
			if(queryPortion)
			{
				setQuery(new QueryString(queryPortion));
			}
			
			//Removing the last item if its blank - this is to ensure that if a trailing slash is
			//put on the end of the address we do not count the proceeding null value as a node
			if(_uriNodeStrings[_uriNodeStrings.length-1] == null || _uriNodeStrings[_uriNodeStrings.length-1] == "")
			{
				_uriNodeStrings.splice(_uriNodeStrings.length-1,1);
			}
		}
		
		protected var _uri:String;
		
		/**
		 * Returns the uri represented by this packet. E.g. "en-gb/galleries/people"
		 */
		public function get uri():String
		{
			return _uri;
		}
		
		/**
		 * Returns the uri from a given depth
		 */
		public function getUriNodeStringAtDepth(index:uint):String
		{
			return _uriNodeStrings[index];
		}
		
		/**
		 * Returns whether or not this packet has a child at a given depth
		 */
		public function hasChildAtDepth(depth:uint):Boolean
		{
			return !!getUriNodeStringAtDepth(depth);
		}
		
		/**
		 * Returns the number of uri nodes in the request.
		 */
		public function get length():uint
		{
			return _uriNodeStrings.length;
		}
	}
}