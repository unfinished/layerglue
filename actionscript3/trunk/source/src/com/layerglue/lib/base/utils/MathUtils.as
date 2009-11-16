package com.layerglue.lib.base.utils 
{
	/**
	 * @author LayerGlue
	 */
	public class MathUtils extends Object 
	{
		/**
		 * Returns a random number between two values.
		 */
		public static function randomNumber(low:Number, high:Number):Number
		{		
			return Math.random() * (high - low) + low;
		}
		
		/**
		 * Returns a random integer between two values.
		 */
		public static function randomInt(low:int, high:int):int
		{		
			return Math.round(Math.random() * (high - low)) + low;
		}
		
		/**
		 * Performs a modulo operation where the result retains the sign of the dividend.
		 * (The normal actionscript modulo operation (%) retains the sign of the divisor.)
		 */
		public static function mod(a:Number, b:Number):Number
		{
	        return a - (b * Math.floor(a/b));
		}
	}
}
