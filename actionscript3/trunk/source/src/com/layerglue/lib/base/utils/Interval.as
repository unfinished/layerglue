package com.layerglue.lib.base.utils
{
	/**
	 * Represents a numeric interval.
	 * 
	 * @author Matt Sweetman
	 */
	public class Interval
	{
		/**
		 * The start point of the interval.
		 */
		public var start:Number;
		
		/**
		 * The end point of the interval.
		 */
		public var end:Number;
		
		/**
		 * Creates a new Interval object.
		 */
		public function Interval(start:Number, end:Number)
		{
			this.start = start;
			this.end = end;
		}
		
		/**
		 * Interval duration.
		 */
		public function get duration():Number
		{
			return end - start;
		}
		
		/**
		 * Absolute interval duration.
		 */
		public function get absDuration():Number
		{
			return Math.abs(duration);
		}
		
		/**
		 * Max/upper end-point of the interval, regardless of positive & negative start/end points.
		 */
		public function get maxEndPoint():Number
		{
			return Math.max(start, end);
		}
		
		/**
		 * Min/lower end-point of the interval, regardless of positive & negative start/end points.
		 */
		public function get minEndPoint():Number
		{
			return Math.min(start, end);
		}
		
		/**
		 * Whether the interval contains the specified numeric value, inclusive of end-points.
		 * 
		 * @param num The numeric value to test
		 * @return True if the numeric value falls between the interval end-points
		 */
		public function contains(num:Number):Boolean
		{
			return num >= minEndPoint && num <= maxEndPoint;
		}
		
		/**
		 * Checks whether one interval intersects another, inclusive of end-points.
		 * 
		 * @param i1 First interval
		 * @param i2 Second interval
		 * @return Whether the two intervals intersect
		 */
		public static function intersects(i1:Interval, i2:Interval):Boolean
		{
			if (i1.minEndPoint > i2.maxEndPoint || i1.maxEndPoint < i2.minEndPoint)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
	}
}