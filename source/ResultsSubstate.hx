package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import lime.app.Application;
import flixel.math.FlxMath;
import flixel.addons.display.FlxBackdrop;
import CoolUtil;
import PlayState;

class ResultsSubstate extends MusicBeatSubstate
{
    var camBoobie:FlxCamera;

    var bg1:FlxSprite;
    var bg2:FlxSprite;
    var bottomText:FlxText;
    var songText1:FlxText;
    var songText2:FlxText;
    var ratingImg:FlxSprite;
    var scoreText1:FlxText;
    var scoreText2:FlxText;
    var miscText:FlxText;

    var botplayText:FlxText;
    var practiceText:FlxText;
    var mechanicText:FlxText;

    var lerpScore:Int = 0;
    var intentedScore:Int;

    var amountwowo:Int;

    var canLeave:Bool = false;
    var woowop:Bool = false;
    
	public function new(song:String, ratingName:String, score:Int, accuracy:Int, misses:Int, noteshit:Int, sick:Int, good:Int, bad:Int, shit:Int, maxcombo:Int, bplay:Bool, pmode:Bool)
	{
		super();

        intentedScore = score;

        camBoobie = new FlxCamera();
		camBoobie.bgColor.alpha = 0;
		FlxG.cameras.add(camBoobie);
        camBoobie.alpha = 0;
        
        bg1 = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg1.alpha = .4;
		bg1.scrollFactor.set();
        bg1.cameras = [camBoobie];
		add(bg1);

        bg2 = new FlxSprite(0, FlxG.height - 30).makeGraphic(FlxG.width, 30, FlxColor.BLACK);
		bg2.alpha = 0;
		bg2.scrollFactor.set();
        bg2.cameras = [camBoobie];
		add(bg2);

        bottomText = new FlxText(0, 0, FlxG.width, "Press ENTER to continue", 18);
		bottomText.setFormat(Paths.font("phantomuff.ttf"), 18, FlxColor.WHITE, CENTER);
		bottomText.antialiasing = ClientPrefs.globalAntialiasing;
        bottomText.screenCenter(X);
        bottomText.y = bg2.y + bg2.height / 2 - bottomText.height / 2;
        bottomText.cameras = [camBoobie];
        bottomText.alpha = 0;
		add(bottomText);

        songText1 = new FlxText(0, 20, FlxG.width, "- Song -", 30);
		songText1.setFormat(Paths.font("phantomuff.ttf"), 30, FlxColor.WHITE, CENTER);
		songText1.antialiasing = ClientPrefs.globalAntialiasing;
        songText1.screenCenter(X);
        songText1.cameras = [camBoobie];
		add(songText1);

        songText2 = new FlxText(0, songText1.y + 35, FlxG.width, song, 45);
		songText2.setFormat(Paths.font("phantomuff.ttf"), 45, FlxColor.WHITE, CENTER);
		songText2.antialiasing = ClientPrefs.globalAntialiasing;
        songText2.screenCenter(X);
        songText2.cameras = [camBoobie];
		add(songText2);

        ratingImg =  new FlxSprite().loadGraphic(Paths.image('results/' + ratingName));
		ratingImg.setGraphicSize(Std.int(ratingImg.width * .35));
        ratingImg.updateHitbox();
		ratingImg.antialiasing = true;
        ratingImg.screenCenter(X);
        ratingImg.y = songText2.y + 25;
        ratingImg.cameras = [camBoobie];
		add(ratingImg);

        scoreText1 = new FlxText(0, ratingImg.y + ratingImg.height, FlxG.width, "- Score -", 20);
		scoreText1.setFormat(Paths.font("phantomuff.ttf"), 20, FlxColor.WHITE, CENTER);
		scoreText1.antialiasing = ClientPrefs.globalAntialiasing;
        scoreText1.screenCenter(X);
        scoreText1.cameras = [camBoobie];
		add(scoreText1);

        scoreText2 = new FlxText(0, scoreText1.y + 25, FlxG.width, '' + intentedScore, 40);
		scoreText2.setFormat(Paths.font("phantomuff.ttf"), 40, FlxColor.WHITE, CENTER);
		scoreText2.antialiasing = ClientPrefs.globalAntialiasing;
        scoreText2.screenCenter(X);
        scoreText2.cameras = [camBoobie];
		add(scoreText2);

        miscText = new FlxText(0, 0, FlxG.width, 'Accuracy: ' + accuracy + '% | Misses: ' + misses + ' | Max Combo: ' + maxcombo + ' | Total Notes Hit: ' + noteshit + '\n(' + sick + ' Sicks, ' + good + ' Goods, ' + bad + ' Bads, ' + shit + ' Shits)', 30);
		miscText.setFormat(Paths.font("phantomuff.ttf"), 27, FlxColor.WHITE, CENTER);
		miscText.antialiasing = ClientPrefs.globalAntialiasing;
        miscText.updateHitbox();
        miscText.screenCenter(X);
        miscText.y = bg2.y - miscText.height - 5;
        miscText.cameras = [camBoobie];
		add(miscText);

        if(bplay){ //cheater
            ratingImg.loadGraphic(Paths.image('results/erm'));
            scoreText1.visible = false;
            scoreText2.visible = false;
            miscText.visible = false;

            botplayText = new FlxText(0, scoreText1.y + 25, FlxG.width, '(USED BOTPLAY)', 45);
		    botplayText.setFormat(Paths.font("phantomuff.ttf"), 45, FlxColor.WHITE, CENTER);
		    botplayText.antialiasing = ClientPrefs.globalAntialiasing;
            botplayText.screenCenter(X);
            botplayText.cameras = [camBoobie];
		    add(botplayText);
        }
        if(pmode){
            practiceText = new FlxText(0, 0, FlxG.width, "(USED PRACTICE MODE)", 35);
            practiceText.setFormat(Paths.font("phantomuff.ttf"), 35, FlxColor.WHITE, RIGHT);
            practiceText.antialiasing = ClientPrefs.globalAntialiasing;
            practiceText.screenCenter(X);
            practiceText.cameras = [camBoobie];
            add(practiceText);
        }

        FlxG.sound.play(Paths.sound('scrollMenu'));

        FlxTween.tween(camBoobie, {alpha: 1}, .5, {ease: FlxEase.cubeInOut});
        new FlxTimer().start(1, function(timeThingh:FlxTimer){

            new FlxTimer().start(3, function(timeThingh:FlxTimer){
                FlxTween.tween(bottomText, {alpha: 1}, 1.5, {ease: FlxEase.cubeInOut});
                FlxTween.tween(bg2, {alpha: .4}, 1.5, {ease: FlxEase.cubeInOut});
                new FlxTimer().start(1.5, function(timeThingh:FlxTimer){
                    canLeave = true;
                });
            });
        });
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
        lerpScore = Math.floor(FlxMath.lerp(lerpScore, intentedScore, CoolUtil.boundTo(elapsed *  10, 0, 1)));
        if (Math.abs(lerpScore - intentedScore) <= 10) lerpScore = intentedScore;
        scoreText2.text = '' + lerpScore;
        scoreText2.screenCenter(X);

		var accepted = controls.ACCEPT;

		if (accepted && canLeave && !woowop)
		{
            woowop = true;
			FlxG.sound.play(Paths.sound('cancelMenu'));
            FlxTween.tween(camBoobie, {alpha: 0}, 1, {ease: FlxEase.cubeInOut, onComplete: function(FlxTwn):Void{
                new FlxTimer().start(0.25, function(timeThingh:FlxTimer){
                    PlayState.endthefuckersong = true;
                    close();
                });
            }});
		}
	}
}
