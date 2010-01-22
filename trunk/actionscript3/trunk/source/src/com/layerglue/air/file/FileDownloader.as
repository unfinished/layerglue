package com.layerglue.air.file
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	public class FileDownloader extends EventDispatcher
	{
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;
		
		private var _request:URLRequest; 
		private var _urlStream:URLStream;
		private var _fileStream:FileStream;
		private var _remotePath:String;
		private var _localFile:File;
		
		public function FileDownloader()
		{
			super();
			
			_fileStream = new FileStream();
		}
		
		private var _bytesLoaded:int;
		
		public function get bytesLoaded():int
		{
			return _bytesLoaded;
		}
		
		private var _bytesTotal:int;
		
		public function get bytesTotal():int
		{
			return _bytesTotal;
		}
		
		public function isDownloading():Boolean
		{
			return !isNaN(_bytesLoaded) && (!isNaN(_bytesTotal) && _bytesLoaded < _bytesTotal);
		}
		
		public function startDownloading(remoteFilePath:String, localFile:File):void
		{
			_remotePath = remoteFilePath;
			_localFile = localFile;
			_request = new URLRequest(remoteFilePath);
			_fileStream.openAsync(localFile, FileMode.WRITE);
			
			_bytesLoaded = NaN;
			_bytesTotal = NaN;
			
			destroyURLStream();
			
			_urlStream = new URLStream();
			_urlStream.addEventListener(ProgressEvent.PROGRESS, downloadProgressHandler, false, 0, true);
			_urlStream.addEventListener(Event.COMPLETE, downloadCompleteHandler, false, 0, true);
			_urlStream.addEventListener(IOErrorEvent.IO_ERROR, errorHandler, false, 0, true);
			
			_urlStream.load(_request);
		}
		
		public function stopDownloading():void
		{
			//If the download was stopped before completing, delete the local file as it will be incomplete
			if(_localFile)
			{
				_localFile.deleteFile();
			}
			
			cleanUp();
		}
		
		private function cleanUp():void
		{
			destroyURLStream();
			_fileStream.close();
			_remotePath = null;
			_localFile = null;
			_bytesLoaded = NaN;
			_bytesTotal = NaN;
		}
		
		private function destroyURLStream():void
		{
			if(_urlStream)
			{
				_urlStream.removeEventListener(ProgressEvent.PROGRESS, downloadProgressHandler, false);
				_urlStream.removeEventListener(Event.COMPLETE, downloadCompleteHandler, false);
				_urlStream.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler, false);
				_urlStream = null;
			}
		}
		
		private function downloadProgressHandler(event:ProgressEvent):void 
		{
			var byteArray:ByteArray = new ByteArray();
			_bytesLoaded = event.bytesLoaded;
			_bytesTotal = event.bytesTotal;
			
			_urlStream.readBytes(byteArray, 0, _urlStream.bytesAvailable);
			_fileStream.writeBytes(byteArray, 0, byteArray.length);
			
			var progressEvent:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
			progressEvent.bytesLoaded = _bytesLoaded;
			progressEvent.bytesTotal = _bytesTotal;
			
			dispatchEvent(progressEvent);
		}
		
		private function downloadCompleteHandler(event:Event):void
		{
			cleanUp();
			
			var completeEvent:Event = new Event(Event.COMPLETE);
			dispatchEvent(completeEvent);           
		}
		
		private function errorHandler(event:Event):void
		{
			dispatchEvent(event.clone());
		}
		
	}
}