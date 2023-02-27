package;

import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite
{
	var DaGame = {
		gameWidth: 1280, // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
		gameHeight: 720,// Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
		initialState:  TitleState, // The FlxState the game starts with.
		zoom: -1.0, // If -1.0, zoom is automatically calculated to fit the window dimensions.
		framerate: 120, // How many frames per second the game should run at.
		skipSplash: true, // Whether to skip the flixel splash screen that appears in release mode.
		startFullscreen: false
	}; // sum coolio stuff i wrote (just to torture the shit out of me)

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (DaGame.zoom == -1)
		{
			var ratioX:Float = stageWidth / DaGame.gameWidth;
			var ratioY:Float = stageHeight / DaGame.gameHeight;
			DaGame.zoom = Math.min(ratioX, ratioY);
			DaGame.gameWidth = Math.ceil(stageWidth / DaGame.zoom);
			DaGame.gameHeight = Math.ceil(stageHeight / DaGame.zoom);
		}

		#if !debug
		DaGame.initialState = TitleState;
		#end

		addChild(new FlxGame(DaGame.gameWidth, DaGame.gameHeight, DaGame.initialState, #if (flixel < "5.0.0") DaGame.zoom ,#end DaGame.framerate, DaGame.framerate, DaGame.skipSplash, DaGame.startFullscreen));

		#if !mobile
		addChild(new FPS(10, 3, 0xFFFFFF));
		addChild(new Memory(10,24,0xffffff));
		#end
	}
}
