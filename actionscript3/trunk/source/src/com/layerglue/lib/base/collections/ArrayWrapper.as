package com.layerglue.lib.base.collections
{
	import flash.utils.Proxy;
	
	[ExcludeClass]
	public class ArrayWrapper extends Proxy
	{
		protected var _array:Array;
		
		public function ArrayWrapper(...rest)
		{
			super();
			
			_array = [];
			
			var item:*
			for each(item in rest)
			{
				_array.push(item);
			}
		}
		
		public function getItemAtIndex(index:int):*
		{
			return _array[index];
		}
		
		// ---------- Array method implementation ----------
		
		public function concat(...args):void
		{
			_array.concat(args);
		}
		
		public function every(callback:Function, thisObject:Object=null):Boolean
		{
			return _array.every(callback, thisObject);
		}
		
		public function filter(callback:Function, thisObject:Object=null):Array
		{
			return _array.fileter(callback, thisObject);
		}
		
		public function forEach(callback:Function, thisObject:Object=null):void
		{
			_array.forEach(callback, thisObject);
		}
		
		public function hasOwnProperty(name:Object=0):Boolean
		{
			return _array.hasOwnProperty(name);
		}
		
		public function indexOf(searchElement:Object, fromIndex:Object=0):int
		{
			return _array.indexOf(searchElement, fromIndex);
		}
		
		public function isPrototypeOf(theClass:Object=0):Boolean
		{
			return _array.isPrototypeOf(theClass);
		}
		
		public function join(sep:Object=0):String
		{
			return _array.join(sep);
		}
		
		public function lastIndexOf(searchElement:Object, fromIndex:Object=0x7fffffff):int
		{
			return _array.lastIndexOf(searchElement, fromIndex);
		}
		
		public function length():uint
		{
			return _array.length;
		}
		
		public function map(callback:Function, thisObject:Object=null):Array
		{
			return _array.map(callback, thisObject);
		}
		
		public function pop():Object
		{
			return _array.pop();
		}
		
		public function propertyIsEnumerable(V:Object=0):Boolean
		{
			return _array.propertyIsEnumerable(V);
		}
		
		public function push(...args):uint
		{
			return _array.push(args);
		}
		
		public function reverse():Array
		{
			return _array.reverse();
		}
		
		public function shift():Object
		{
			return _array.shift();
		}
		
		public function slice(A:Object=0.0, B:Object=4.294967295E9):Array
		{
			return _array.slice(A, B);
		}
		
		public function some(callback:Function, thisObject:Object=null):Boolean
		{
			return _array.some(callback, thisObject);
		}
		
		public function sort(...args):Array
		{
			return _array.sort(args);
		}
		
		public function sortOn(names:Object, options:Object=0.0, ...rest):Array
		{
			return _array.sortOn(names, options, rest);
		}
		
		public function splice(startIndex:int, deleteCount:uint, ...values):Array
		{
			return _array.splice(startIndex, deleteCount, values);
		}
		
		public function unshift(...args):uint
		{
			return _array.unshift(args);
		}
		
		// -------------------------------------------------
		
	}
}