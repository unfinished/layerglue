package com.layerglue.lib.base.utils
{
	/**
	 * A collection of static utility methods for dealing with Strings.
	 */
	public class StringUtils
	{
		public static const ALPHA_NUMERIC_RESTRICTION:String = "A-Z a-z 0-9";
		public static const NUMERIC_RESTRICTION:String = "0-9 + \u0020";
		public static const EMAIL_RESTRICTION:String = "A-Z a-z 0-9 @ . _ \\-";
		
		public function StringUtils()
		{
			super();
		}
		
		//TODO Split this out into left and right trim
		public static function trim(string:String):String
	    {
			var startIndex:int = 0;
			while (isWhitespace(string.charAt(startIndex)))
			{
				++startIndex;
			}
	        
			var endIndex:int = string.length - 1;
			while (isWhitespace(string.charAt(endIndex)))
			{
				--endIndex;
			}
			
			if (endIndex >= startIndex)
			{
				return string.slice(startIndex, endIndex + 1);
			}
	        else
	        {
	            return "";
	        }
	    }
		
		/**
		 * Returns whether or not the supplied value is whitespace. As well as spaces this includes
		 * the following: \t, \r, \n, \f.
		 */
		public static function isWhitespace(character:String):Boolean
	    {
	        switch (character)
	        {
	            case " ":
	            case "\t":
	            case "\r":
	            case "\n":
	            case "\f":
	                return true;
	
	            default:
	                return false;
	        }
	    }
	    
	    //TODO Change this to a more generic method that removes trailing characters/patterns
	    public static function removeTrailingSlash(string:String):String
		{
			var endIndex:int = string.length - 1;
			while (string.charAt(endIndex) == "/")
			{
				--endIndex;
			}
			
			return string.slice(0, endIndex+1);
		}
		
		/**
		 * Converts a delimeted string to camel case.
		 * Strips out the delimeters and uppercases the succeeding character.
		 */
		public static function toCamelCase(string:String, delimeter:String):String
		{
			var split:Array = string.split(delimeter);
			for (var i:int = 1; i < split.length; i++)
			{
				var str:String = (split[i] as String);
				split[i] = str.charAt(0).toUpperCase() + str.substring(1);
			}
			return split.join('');
		}
	}
}