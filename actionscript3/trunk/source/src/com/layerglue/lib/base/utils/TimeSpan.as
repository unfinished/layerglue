package com.layerglue.lib.base.utils
{
	/**
	 * Represents an interval of time in various units. Use the static factory methods as
	 * shortcut to create time spans from different unit-types.
	 */
	public class TimeSpan
	{
		/**
		 * The number of milliseconds in one day
		 */
		public static const MILLISECONDS_IN_DAY : Number = 86400000;
		
		/**
		 * The number of milliseconds in one hour
		 */
		public static const MILLISECONDS_IN_HOUR : Number = 3600000;
		
		/**
		 * The number of milliseconds in one minute
		 */
		public static const MILLISECONDS_IN_MINUTE : Number = 60000;
		
		/**
		 * The number of milliseconds in one second
		 */
		public static const MILLISECONDS_IN_SECOND : Number = 1000;
		
		protected var _totalMilliseconds:Number;
		
		/**
		 * Creates a new TimeSpan object with the duration specified in milliseconds.
		 * 
		 * @param milliseconds Number representing the time span duration
		 */
		public function TimeSpan(milliseconds:Number)
		{
			_totalMilliseconds = Math.floor(milliseconds);
		}
		
		/**
		 * Gets the number of whole days
		 * 
		 * @example In a TimeSpan created from TimeSpan.fromHours(25), 
		 *                      totalHours will be 1.04, but hours will be 1 
		 * @return A number representing the number of whole days in the TimeSpan
		 */
		public function get days():Number
		{
			return Math.floor(_totalMilliseconds / MILLISECONDS_IN_DAY);
		}
		
		/**
		 * Gets the number of whole hours (excluding entire days)
		 * 
		 * @example In a TimeSpan created from TimeSpan.fromMinutes(1500), 
		 *                      totalHours will be 25, but hours will be 1 
		 * @return A number representing the number of whole hours in the TimeSpan
		 */
		public function get hours():Number
		{
			return Math.floor( (_totalMilliseconds / MILLISECONDS_IN_HOUR) % 24 );
		}
		
		/**
		 * Gets the number of whole minutes (excluding entire hours)
		 * 
		 * @example In a TimeSpan created from TimeSpan.fromMilliseconds(65500), 
		 *                      totalSeconds will be 65.5, but seconds will be 5 
		 * @return A number representing the number of whole minutes in the TimeSpan
		 */
		public function get minutes():Number
		{
			return Math.floor( (_totalMilliseconds / MILLISECONDS_IN_MINUTE) % 60 ); 
		}
		
		/**
		 * Gets the number of whole seconds (excluding entire minutes)
		 * 
		 * @example In a TimeSpan created from TimeSpan.fromMilliseconds(65500), 
		 *                      totalSeconds will be 65.5, but seconds will be 5 
		 * @return A number representing the number of whole seconds in the TimeSpan
		 */
		public function get seconds():Number
		{
			return Math.floor( (_totalMilliseconds / MILLISECONDS_IN_SECOND) % 60 );
		}
		
		/**
		 * Gets the number of whole milliseconds (excluding entire seconds)
		 * 
		 * @example In a TimeSpan created from TimeSpan.fromMilliseconds(2123), 
		 *                      totalMilliseconds will be 2001, but milliseconds will be 123 
		 * @return A number representing the number of whole milliseconds in the TimeSpan
		 */
		public function get milliseconds():Number
		{
			return Math.floor( (_totalMilliseconds) % 1000 );
		}
		
		/**
		 * Gets the total number of days.
		 * 
		 * @example In a TimeSpan created from TimeSpan.fromHours(25), 
		 *                      totalHours will be 1.04, but hours will be 1 
		 * @return A number representing the total number of days in the TimeSpan
		 */
		public function get totalDays():Number
		{
			return _totalMilliseconds / MILLISECONDS_IN_DAY;
		}
		
		/**
		 * Gets the total number of hours.
		 * 
		 * @example In a TimeSpan created from TimeSpan.fromMinutes(1500), 
		 *                      totalHours will be 25, but hours will be 1 
		 * @return A number representing the total number of hours in the TimeSpan
		 */
		public function get totalHours():Number
		{
			return _totalMilliseconds / MILLISECONDS_IN_HOUR;
		}
		
		/**
		 * Gets the total number of minutes.
		 * 
		 * @example In a TimeSpan created from TimeSpan.fromMilliseconds(65500), 
		 *                      totalSeconds will be 65.5, but seconds will be 5 
		 * @return A number representing the total number of minutes in the TimeSpan
		 */
		public function get totalMinutes():Number
		{
			return _totalMilliseconds / MILLISECONDS_IN_MINUTE;
		}
		
		/**
		 * Gets the total number of seconds.
		 * 
		 * @example In a TimeSpan created from TimeSpan.fromMilliseconds(65500), 
		 *                      totalSeconds will be 65.5, but seconds will be 5 
		 * @return A number representing the total number of seconds in the TimeSpan
		 */
		public function get totalSeconds():Number
		{
			return _totalMilliseconds / MILLISECONDS_IN_SECOND;
		}
		
		/**
		 * Gets the total number of milliseconds.
		 * 
		 * @example In a TimeSpan created from TimeSpan.fromMilliseconds(2123), 
		 *                      totalMilliseconds will be 2001, but milliseconds will be 123 
		 * @return A number representing the total number of milliseconds in the TimeSpan
		 */
		public function get totalMilliseconds():Number
		{
			return _totalMilliseconds;
		}
		
		/**
		 * Factory method for creating a TimeSpan from the difference between two dates
		 * 
		 * Note that start can be after end, but it will result in negative values. 
		 *  
		 * @param start The start date of the timespan
		 * @param end The end date of the timespan
		 * @return A TimeSpan that represents the difference between the dates
		 * 
		 */             
		public static function createFromDates(start:Date, end:Date):TimeSpan
		{
			return new TimeSpan(end.time - start.time);
		}
		
		/**
		 * Factory method for creating a TimeSpan from the specified number of milliseconds
		 * @param milliseconds The number of milliseconds in the timespan
		 * @return A TimeSpan that represents the specified value
		 */             
		public static function createFromMilliseconds(milliseconds:Number):TimeSpan
		{
			return new TimeSpan(milliseconds);
		}
		
		/**
		 * Factory method for creating a TimeSpan from the specified number of seconds
		 * @param seconds The number of seconds in the timespan
		 * @return A TimeSpan that represents the specified value
		 */     
		public static function createFromSeconds(seconds:Number):TimeSpan
		{
			return new TimeSpan(seconds * MILLISECONDS_IN_SECOND);
		}
		
		/**
		 * Factory method for creating a TimeSpan from the specified number of minutes
		 * @param minutes The number of minutes in the timespan
		 * @return A TimeSpan that represents the specified value
		 */     
		public static function createFromMinutes(minutes:Number):TimeSpan
		{
			return new TimeSpan(minutes * MILLISECONDS_IN_MINUTE);
		}
		
		/**
		 * Factory method for creating a TimeSpan from the specified number of hours
		 * @param hours The number of hours in the timespan
		 * @return A TimeSpan that represents the specified value
		 */     
		public static function createFromHours(hours:Number):TimeSpan
		{
			return new TimeSpan(hours * MILLISECONDS_IN_HOUR);
		}
		
		/**
		 * Factory method for creating a TimeSpan from the specified number of days
		 * @param days The number of days in the timespan
		 * @return A TimeSpan that represents the specified value
		 */     
		public static function createFromDays(days:Number):TimeSpan
		{
			return new TimeSpan(days * MILLISECONDS_IN_DAY);
		}
	}
}