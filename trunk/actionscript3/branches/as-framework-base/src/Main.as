package
{
	
	import com.client.project.io.InitialLoadManager;
	import com.layerglue.components.LGButton;
	import com.layerglue.components.LGLabel;
	import com.layerglue.flash.applications.IPreloadableFlashApplication;
	import com.layerglue.flash.loaders.DisplayLoader;
	import com.layerglue.font.FontManager;
	import com.layerglue.lib.base.io.FlashVars;
	
	import fl.controls.Button;
	import fl.managers.StyleManager;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	[Frame(factoryClass="com.client.project.preloader.CustomPreloaderDisplay")]
	
	public class Main extends Sprite implements IPreloadableFlashApplication
	{
		public var fontManager:FontManager;
		
		private var _initialLoadManager:InitialLoadManager;
		
		private var _displayLoader:DisplayLoader;
		
		public function Main()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			createChildren();
		}
		
		public function createChildren():void
		{
			drawStuff();
		}
		
		public function startInitialLoad():void
		{
			_initialLoadManager = new InitialLoadManager();
			_initialLoadManager.addEventListener(Event.COMPLETE, initialLoadManagerComplete);
			_initialLoadManager.start();
		}
		
		private function initialLoadManagerComplete(event:Event):void
		{
			
		}
		
		private function drawStuff():void
		{
			trace("Main.drawStuff: " + stage);
			
			/* 
			var tf:TextFormat = new TextFormat("RegionalFont", 12, 0x333333, false);
			
			var t:TextField = new TextField();
			t.defaultTextFormat = tf;
			t.embedFonts = true;
			t.antiAliasType = AntiAliasType.ADVANCED;
			t.autoSize = TextFieldAutoSize.LEFT;
			t.rotation = 5;
			
			t.text = "Hello embedded font";
			addChild(t);
			
			var a:Array = Font.enumerateFonts();
			 */
			
			var b2:Button = new Button();
			b2.label = "Default Flash Component";
			b2.y = 30;
			addChild(b2);
			
			var b:LGButton = new LGButton();
			b.label = "Custom LayerGlue Component";
			b.y = 60;
			addChild(b);
			
			var l:LGLabel = new LGLabel();
			l.text = "Custom LayerGlue Label";
			l.autoSize = TextFieldAutoSize.LEFT;
			l.htmlText = _initialLoadManager.structureRoot.title;
			l.y = 5;
			addChild(l);
						
			StyleManager.setStyle( "textFormat", new TextFormat("RegionalFont", 12, 0x333333, false) );
			StyleManager.setStyle( "antiAliasType", AntiAliasType.ADVANCED);
			StyleManager.setStyle( "embedFonts", true );
			
			
			graphics.beginFill(Number(_initialLoadManager.localeConfigSource.getValueByReference("squareColor")), 1);
			graphics.drawRoundRect(100, 300, _initialLoadManager.localeConfigSource.getValueByReference("squareWidth"), _initialLoadManager.localeConfigSource.getValueByReference("squareHeight"), _initialLoadManager.localeConfigSource.getValueByReference("squareCornerRadius"), _initialLoadManager.localeConfigSource.getValueByReference("squareCornerRadius"));
			graphics.endFill();
			
		}
	}
}
