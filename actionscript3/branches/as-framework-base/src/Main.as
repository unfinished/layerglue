package
{
	import com.layerglue.components.LGButton;
	import com.layerglue.components.LGLabel;
	import com.layerglue.font.FontManager;
	
	import fl.managers.StyleManager;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Main extends Sprite
	{
		public var fontManager:FontManager;
		
		public function Main()
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			fontManager = FontManager.getInstance();
			fontManager.addEventListener(Event.COMPLETE, fontLoadingComplete, false, 0, true);		
			fontManager.loadCompiledFont("flash-assets/fonts/Western.swf");
		}
		
		private function fontLoadingComplete(event:Event):void
		{
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
			
			var b:LGButton = new LGButton();
			b.label = "My button with long txt";
			b.y = 30;
			addChild(b);
			
			var l:LGLabel = new LGLabel();
			//l.text = "My label";
			l.autoSize = TextFieldAutoSize.LEFT;
			l.htmlText = "html text with inline styles";
			l.y = 55;
			addChild(l);
						
			StyleManager.setStyle( "textFormat", new TextFormat("RegionalFont", 11, 0x333333, false) );
			StyleManager.setStyle( "antiAliasType", AntiAliasType.ADVANCED);
			StyleManager.setStyle( "embedFonts", true );
			
		}
	}
}
