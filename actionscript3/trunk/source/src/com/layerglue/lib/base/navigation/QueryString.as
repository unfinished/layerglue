package com.layerglue.lib.base.navigation
{
	import com.layerglue.lib.base.collections.HashMap;
	
	
	/**
	 * <p>A representation of a url style query string e.g. locale=en-gb&page=gallery</p>
	 */
	public class QueryString extends Object
	{
		
		public function QueryString(string:String)
		{
			super();
			
			_variables = new HashMap();
			this.string = string;
		}
		
		//TODO Change this functionality so a string is not stored, and get string dynamically
		//constructs the string from the available variables - to ensure that added variables are
		//included.
		private var _string:String;
		
		/**
		 * The raw query string.
		 */
		public function get string():String
		{
			return _string;
		}
		
		public function set string(value:String):void
		{
			_string = value;
			
			parseVariables(_string);
		}
		
		/**
		 * Parses the raw string value, turning it into key value pairs.
		 */
		private function parseVariables(variableString:String):void
		{
			clearVariables();
			
			if(variableString)
			{
				var arr:Array = variableString.split("&");
				for each(var pair:String in arr)
				{
					var values:Array = pair.split("=");
					addVariable(values[0], values[1]);
				}
			}
		}
		
		private var _variables:HashMap;
		
		/**
		 * A Hashmap of the variables represented by the raw query string.
		 */
		public function get variables():HashMap
		{
			return _variables;
		}
		
		/**
		 * Whether or not the query string contains a certain variable
		 */
		public function hasVariable(key:String):Boolean
		{
			return _variables.containsKey(key);
		}
		
		/**
		 * Returns a the value relating to a specified key.
		 */
		public function getVariable(key:String):*
		{
			return _variables.get(key);
		}
		
		/**
		 * Adds a key value pair to the variables.
		 */
		public function addVariable(key:String, value:String):void
		{
			_variables.put(key, value);
		}
		
		/**
		 * Clears all the variables
		 */
		protected function clearVariables():void
		{
			if(_variables)
			{
				_variables.clear();
			}
		}
		
	}
}