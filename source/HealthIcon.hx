package;

import flixel.FlxSprite;
import openfl.Assets as OpenflAssets;
using StringTools;
class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	var char:String = 'bf';
	public var isPlayer:Bool = false;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		this.char = char;
		this.isPlayer = isPlayer;
		changeIcon(char);
	}
	public function changeIcon(char:String){
		if(this.char != "none"){
			if(char != 'none'){
				loadGraphic(Paths.image('icons/' + char), true, 150, 150);
			}
			else{
				loadGraphic(Paths.image('icons/blank'));
			}
			animation.add(char, [0,1,2], 0,false,isPlayer);
			animation.play(char);
			scrollFactor.set(); // goofy lowkey loader

		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
