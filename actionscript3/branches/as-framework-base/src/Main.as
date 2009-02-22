package
{
	
	import com.client.project.io.InitialLoadManager;
	import com.layerglue.components.LGBox;
	import com.layerglue.components.LGButton;
	import com.layerglue.components.LGLabel;
	import com.layerglue.flash.applications.IPreloadableFlashApplication;
	import com.layerglue.flash.loaders.DisplayLoader;
	import com.layerglue.font.FontManager;
	
	import fl.controls.Button;
	import fl.events.ComponentEvent;
	import fl.managers.StyleManager;
	
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
		
		private var box:LGBox;
		
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
			//trace("Main.drawStuff: " + stage);
			
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
			 
			box = new LGBox();
			box.y = 30;
			addChild(box);
			
			var addButton:Button = new Button();
			addButton.label = "Add";
			addButton.y = 60;
			addButton.addEventListener(ComponentEvent.BUTTON_DOWN, onAddButtonClick);
			addChild(addButton);
			var removeButton:Button = new Button();
			removeButton.label = "Remove";
			removeButton.y = 60;
			removeButton.x = 100;
			removeButton.addEventListener(ComponentEvent.BUTTON_DOWN, onRemoveButtonClick);
			addChild(removeButton);
			var resizeButton:Button = new Button();
			resizeButton.label = "Resize";
			resizeButton.y = 60;
			resizeButton.x = 200;
			resizeButton.addEventListener(ComponentEvent.BUTTON_DOWN, onResizeButtonClick);
			addChild(resizeButton);
			var labelButton:Button = new Button();
			labelButton.label = "Rename";
			labelButton.y = 60;
			labelButton.x = 300;
			labelButton.addEventListener(ComponentEvent.BUTTON_DOWN, onLabelButtonClick);
			addChild(labelButton);
			
			var b2:Button = new Button();
			b2.label = "Default Flash Component";
			//b2.y = 30;
			box.addChild(b2);
			
			var b:Button = new Button();
			b.label = "Custom LayerGlue Component";
			//b.y = 60;
			box.addChild(b);
			
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
		
		public function onAddButtonClick(event:ComponentEvent):void
		{
			var b:LGButton = new LGButton();
			b.label = "new layerglue buttonsss";
			box.addChild(b);
		}
		
		public function onRemoveButtonClick(event:ComponentEvent):void
		{
			box.removeChildAt(0);
		}
		
		public function onResizeButtonClick(event:ComponentEvent):void
		{
			box.getChildAt(0).width = 200;
		}
		
		public function onLabelButtonClick(event:ComponentEvent):void
		{
			(box.getChildAt(0) as Button).label = "WooWoo";
		}
	}
}
