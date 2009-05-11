package com.layerglue.lib.base.substitution.sources
{

	/**
	 * A class that deserializes an Excel spreadsheet into a hashmap to allow it to act as an
	 * ISubstitution source for an ISubstitutor.
	 */
	public class ExcelSubstitutionSource extends SubstitutionSource
	{
		namespace defaultNamespace = "urn:schemas-microsoft-com:office:spreadsheet";
		namespace spreadsheetNamespace = "urn:schemas-microsoft-com:office:spreadsheet";
		
		private var _xml:XML;
		
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
		
		private var _worksheets:Array;
		
		/**
		 * <p>The worksheets present in the workbook to be included.</p>
		 * <p>Specific worksheets should be passed in as an array of strings, or null to specify all
		 * worksheets.</p>
		 */
		public function get worksheets():Array
		{
			return _worksheets;
		}
		
		public function set worksheets(value:Array):void
		{
			_worksheets = value;
		}
		
		private var _typeColumnIndex:int;
		/**
		 * The index for the column that contains type references. If this is set to null, no
		 * casting will be attempted.
		 */
		public function get typeColumnIndex():int
		{
			return _typeColumnIndex;
		}
		
		public function set typeColumnIndex(value:int):void
		{
			_typeColumnIndex = value;
		}
		
		/**
		 * 
		 * @ param xml					The Excel xml to be processed
		 * @ param keyColumnIndex		The index of the columm containing the key values
		 * @ param valueColumnIndex		The index of the column containing the values to be used for substitution
		 * @ param ignoreColumnIndex	The index of the column containing ignore flags, or -1 if none should be ignored
		 * @ param ignoreString			The string used in the ignore column to mark something as ignored
		 * @ param worksheets			The worksheets present in the workbook to be included. Passing null will use all worksheets
		 */
		public function ExcelSubstitutionSource(
			xml:XML,
			keyColumnIndex:int,
			valueColumnIndex:int,
			ignoreColumnIndex:int=-1,
			ignoreString:String="",
			worksheets:Array=null,
			typeColumnIndex:int=undefined)
		{
			_xml = xml;
			this.keyColumnIndex = keyColumnIndex;
			this.valueColumnIndex = valueColumnIndex;
			this.ignoreColumnIndex = ignoreColumnIndex;
			this.ignoreString = ignoreString;
			this.worksheets = worksheets;
			this.typeColumnIndex = typeColumnIndex;
			
			deserialize(_xml);
		}
		
		/**
		 * Creates a HashMap of key value pairs contained by the Excel xml
		 */
		protected function deserialize(xml:XML):void
		{
			_xml = xml;
			clearMap();
			clearReferences();
			
			//Putting us into the default namespace for the excel document
			
			use namespace defaultNamespace;
			
			//Iterate through all the row nodes in the document
			var rowXML:XML;
			for each(rowXML in _xml..Row)
			{
				var rowArray:Array = createRowArray(rowXML);
				
				trace("rowArray: "+rowArray[valueColumnIndex]);
				
				//Before adding values, check if they are flagged as ignored
				if(!shouldIgnoreRow(rowArray) && rowArray[keyColumnIndex] != null && rowArray[keyColumnIndex] != "")
				{
					addItem(rowArray[keyColumnIndex], rowArray[valueColumnIndex], rowArray[typeColumnIndex]);
				}
			}
		}
		
		/**
		 * Returns whether or not a row should be ignored.
		 */
		private function shouldIgnoreRow(row:Array):Boolean
		{
			if(ignoreColumnIndex != -1)
			{
				return row[ignoreColumnIndex] == ignoreString;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * Creates an array of the data values of cells contained within the xml of an Excel row
		 */
		private function createRowArray(rowXML:XML):Array
		{
			var rowArray:Array = [];
			
			use namespace spreadsheetNamespace;
			rowXML.removeNamespace(spreadsheetNamespace);
			
			var indexCounter:uint = 1;
			for(var i:uint=0 ; i<rowXML.Cell.length() ; i++)
			{
				var cell:XML = rowXML.Cell[i];
				
				//If cell has no defined Index attribute increment the counter, otherwise set the
				//indexCounter to the value defined in the cell
				if((cell.@Index.toString() as String).length > 0)
				{
					indexCounter = cell.@Index;
				}
				
				//Assign the data to the correct index of the rowArray
				rowArray[indexCounter] = cell.Data.text().toString();
				
				indexCounter++;
			}
			return rowArray;
		}
		
	}
}