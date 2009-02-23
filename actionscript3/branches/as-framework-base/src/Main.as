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
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	[Frame(factoryClass="com.client.project.preloader.CustomRootPreloader")]
	
	public class Main extends Sprite implements IPreloadableFlashApplication
	{
		public var fontManager:FontManager;
		
		private var _initialLoadManager:InitialLoadManager;
		
		private var _displayLoader:DisplayLoader;
		
		public var box:LGBox;
		public var button1:LGButton;
		public var button2:LGButton;
		
		public function Main()
		{
			super();
		}
		
		public function show(preloaderDisplay:DisplayObject):void
		{
			if(preloaderDisplay.parent && preloaderDisplay.parent.contains(preloaderDisplay))
			{
				preloaderDisplay.parent.removeChild(preloaderDisplay);
			}
			
			createChildren();
		}
		
		public function createChildren():void
		{
			drawStuff();
		}
		
		public function startInitialLoad():void
		{
			_initialLoadManager = new InitialLoadManager();
			_initialLoadManager.start();
		}
		
		private function drawStuff():void
		{
					
			box = new LGBox(LGBox.VERTICAL, 5);
			box.y = 30;
			addChild(box);
			
			var addButton:Button = new Button();
			addButton.label = "Add Btn";
			addButton.y = 0;
			addButton.addEventListener(ComponentEvent.BUTTON_DOWN, onAddButtonClick);
			addChild(addButton);
			var removeButton:Button = new Button();
			removeButton.label = "Remove";
			removeButton.y = 0;
			removeButton.x = 100;
			removeButton.addEventListener(ComponentEvent.BUTTON_DOWN, onRemoveButtonClick);
			addChild(removeButton);
			var resizeButton:Button = new Button();
			resizeButton.label = "Resize";
			resizeButton.y = 0;
			resizeButton.x = 200;
			resizeButton.addEventListener(ComponentEvent.BUTTON_DOWN, onResizeButtonClick);
			addChild(resizeButton);
			var labelButton:Button = new Button();
			labelButton.label = "Rename";
			labelButton.y = 0;
			labelButton.x = 300;
			labelButton.addEventListener(ComponentEvent.BUTTON_DOWN, onLabelButtonClick);
			addChild(labelButton);
			var txtButton:Button = new Button();
			txtButton.label = "Add Txt";
			txtButton.y = 0;
			txtButton.x = 400;
			txtButton.addEventListener(ComponentEvent.BUTTON_DOWN, onTxtButtonClick);
			addChild(txtButton);
			var autoButton:Button = new Button();
			autoButton.label = "Btn Autosize";
			autoButton.y = 0;
			autoButton.x = 500;
			autoButton.addEventListener(ComponentEvent.BUTTON_DOWN, onAutoButtonClick);
			addChild(autoButton);
			var dirButton:Button = new Button();
			dirButton.label = "Box direction";
			dirButton.y = 0;
			dirButton.x = 600;
			dirButton.addEventListener(ComponentEvent.BUTTON_DOWN, onDirButtonClick);
			addChild(dirButton);
			
			onTxtButtonClick(null);
			onAddButtonClick(null);
			onTxtButtonClick(null);
			
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
			b.label = "new layerglue buttonsss long";
			b.autoSize = true;
			box.addChild(b);
		}
		
		public function onRemoveButtonClick(event:ComponentEvent):void
		{
			box.removeChildAt(0);
		}
		
		public function onResizeButtonClick(event:ComponentEvent):void
		{
			box.getChildAt(0).width = 50;
		}
		
		public function onLabelButtonClick(event:ComponentEvent):void
		{
			(box.getChildAt(0) as LGButton).label = "ooooooooooooooooo";
		}
		
		public function onTxtButtonClick(event:ComponentEvent):void
		{
			var b:LGLabel = new LGLabel();
			b.text = "new label";
			b.autoSize = TextFieldAutoSize.LEFT;
			box.addChild(b);
		}
		
		public function onAutoButtonClick(event:ComponentEvent):void
		{
			(box.getChildAt(0) as LGButton).autoSize = !(box.getChildAt(0) as LGButton).autoSize;
			//(box.getChildAt(0) as DisplayObject).x = 30;
		}
		
		public function onDirButtonClick(event:ComponentEvent):void
		{
			//(box.getChildAt(0) as LGButton).autoSize = !(box.getChildAt(0) as LGButton).autoSize;
			//(box.getChildAt(0) as DisplayObject).x = 30;
			if (box.direction == LGBox.HORIZONTAL)
			{
				box.direction = LGBox.VERTICAL;
			}
			else
			{
				box.direction = LGBox.HORIZONTAL;
			}
		}
	}
}
