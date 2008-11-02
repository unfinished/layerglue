package com.layerglue.lib.base.localisation
{
	
	public class Locale extends Object
	{
		public function Locale(code:String=null, codeDelimeter:String="-")
		{
			super();
			
			this.code = code;
			this.codeDelimeter = codeDelimeter;
		}
		
		private var _code:String;
		
		public function get code():String
		{
			return _code;
		}
		
		public function set code(value:String):void
		{
			_code = value;
		}
		
		/**
		 * The language code specified in the locale code.
		 */
		public function get languageCode():String
		{
			return code.split(codeDelimeter)[0]
		}
		
		/**
		 * The country code specified in the locale code,
		 */
		public function get countryCode():String
		{
			return code.split(codeDelimeter)[1];
		}
		
		private var _textDirection:String;
		
		/**
		 * The text direction of the specified language.
		 */
		public function get textDirection():String
		{
			return _textDirection;
		}
		
		public function set textDirection(value:String):void
		{
			if(value == TextDirection.LEFT_TO_RIGHT || value == TextDirection.RIGHT_TO_LEFT)
			{
				_textDirection = value;
			}
			else
			{
				throw new Error("Tried to set text direction with invalid value: " + value);
			}
		}
		
		private var _codeDelimiter:String;
		
		/**
		 * The delimeter for the code, which defaults to a "-" symbol.
		 */
		public function get codeDelimeter():String
		{
			return _codeDelimiter;
		}
		
		public function set codeDelimeter(value:String):void
		{
			_codeDelimiter = value;
		}
	}
}