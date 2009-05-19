package com.layerglue.lib.base.utils 
{

	/**
	 * @author Jamie Copeland
	 */
	public class MathUtils extends Object 
	{
		public function MathUtils()
		{
			super();
		}
		
		public static function randomNumber(low:Number, high:Number):Number
		{		
			return Math.random() * (high - low) + low;
		}
		
		public static function randomInt(low:int, high:int):int
		{		
			return Math.round(Math.random() * (high - low)) + low;
		}
	}
}
