package com.layerglue.lib.base.utils
{
	public class ImageSubstitutorUtils
	{
		/**
		 * Checks to see if the string contains an image substitution code.
		 */
		static public function isImageSubstitute(str:String):Boolean
		{
			if ( (str.charAt(0) == '@') && (str.charAt(str.length-1) == '@') ) {
				return true;
			} else {
				return false;
			}
		}
		
		static public function convertToStyleName(str:String):String
		{
			return StringUtils.toCamelCase(str.substring(str.indexOf('@')+1, str.lastIndexOf('@')), '.');
		}
	}
}