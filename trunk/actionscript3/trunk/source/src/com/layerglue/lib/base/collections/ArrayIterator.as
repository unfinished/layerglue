package com.layerglue.lib.base.collections
{
	/**
	 * Allows the seqential iteration of an Array instance.
	 */
	public class ArrayIterator extends Object
	{
		private var _source:Array;
		private var _index:int;
		
		public function ArrayIterator(array:Array)
		{
			super();
			
			_source = array;
			_index = -1;
		}
		
		/**
		 * Whether or not another item is available
		 */
		public function hasNext():Boolean
		{
			if(_index < _source.length-1)
			{
				return true;
			}
			
			return false;
		}
		
		/**
		 * The next item in the array
		 */
		public function next():*
		{
			_index++;
			
			return _source[_index];
		}
		
		/**
		 * The length of the source array
		 */
		public function get length():int
		{
			return _source.length;
		}
		
		/**
		 * The current index of the iterator
		 */
		public function get index():int
		{
			return _index;
		}
		
	}
}