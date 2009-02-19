package com.layerglue.lib.base.substitution.sources
{
	public class DelimitedValuesSubstitutionSource extends SubstitutionSource
	{
		private var _csv:String;
		/**
		 * The CSV as a string
		 */
		public function get csv():String
		{
			return _csv;
		}
		
		public function set csv(value:String):void
		{
			_csv = value;
		}
		
		private var _keyColumnIndex:int;
		/**
		 * The index for the column containing keys
		 */
		public function get keyColumnIndex():int
		{
			return _keyColumnIndex;
		}
		
		public function set keyColumnIndex(value:int):void
		{
			_keyColumnIndex = value;
		}
		
		private var _valueColumnIndex:int;
		/**
		 * The index for the column containing values
		 */
		public function get valueColumnIndex():int
		{
			return _valueColumnIndex;
		}
		
		public function set valueColumnIndex(value:int):void
		{
			_valueColumnIndex = value;
		}
		
		private var _ignoreColumnIndex:int;
		/**
		 * The index for the column containing ignoreFlags
		 */
		public function get ignoreColumnIndex():int
		{
			return _ignoreColumnIndex;
		}
		
		public function set ignoreColumnIndex(value:int):void
		{
			_ignoreColumnIndex = value;
		}
		
		private var _ignoreString:String;
		/**
		 * The string that must be entered into the ignore column to mark a row as ignored
		 */
		public function get ignoreString():String
		{
			return _ignoreString;
		}
		
		public function set ignoreString(value:String):void
		{
			_ignoreString = value;
		}
		
		private var _lineBreakCharacter:String;
		/**
		 * The line break character used by the source document. Usually "\n" or "\c"
		 */
		public function get lineBreakCharacter():String
		{
			return _lineBreakCharacter;
		}
		
		public function set lineBreakCharacter(value:String):void
		{
			_lineBreakCharacter = value;
		}
		
		private var _delimeterCharacter:String;
		/**
		 * The
		 */
		public function get delimeterCharacter():String
		{
			return _delimeterCharacter;
		}
		
		public function set delimeterCharacter(value:String):void
		{
			_delimeterCharacter = value;
		}
		
		
		
		public function DelimitedValuesSubstitutionSource(
			csv:String,
			lineBreakCharacter:String,
			delimeterCharacter:String,
			keyColumnIndex:int,
			valueColumnIndex:int,
			ignoreColumnIndex:int=-1,
			ignoreString:String=""
			)
		{
			super();
			
			this.csv = csv;
			this.lineBreakCharacter = lineBreakCharacter;
			this.delimeterCharacter = delimeterCharacter;
			this.keyColumnIndex = keyColumnIndex;
			this.valueColumnIndex = valueColumnIndex;
			this.ignoreColumnIndex = ignoreColumnIndex;
			this.ignoreString = ignoreString;
			
			deserialize();
		}
		
		protected function deserialize():void
		{
			var rows:Array = csv.split(lineBreakCharacter);
			
			for(var i:int=0 ; i < rows.length ; i++)
			{
				var row:String = rows[i];
				var columns:Array = row.split(delimeterCharacter);
				
				if(!(ignoreColumnIndex > -1 && columns[ignoreColumnIndex] == ignoreString))
				{
					addItem(columns[keyColumnIndex], columns[valueColumnIndex]);
				}
			}
		}
		
	}
}