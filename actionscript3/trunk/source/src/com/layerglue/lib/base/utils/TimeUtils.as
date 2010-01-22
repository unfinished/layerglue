package com.layerglue.lib.base.utils
{
	/**
	 * Utilities to help work with units of time.
	 */
	public class TimeUtils
	{
		public static function timeAsDate(time:Number):Date
		{
			return new Date(time);
		}
		
		public static function secondsToMilliseconds(seconds:Number):Number
		{
			return TimeSpan.createFromSeconds(seconds).totalMilliseconds;
		}
		
		public static function minutesToMilliseconds(minutes:Number):Number
		{
			return TimeSpan.createFromMinutes(minutes).totalMilliseconds;
		}
		
		public static function hoursToMilliseconds(hours:Number):Number
		{
			return TimeSpan.createFromHours(hours).totalMilliseconds;
		}
		
		public static function daysToMilliseconds(days:Number):Number
		{
			return TimeSpan.createFromDays(days).totalMilliseconds;
		}
	}
}