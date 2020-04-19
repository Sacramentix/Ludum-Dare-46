package scene;

import networking.Network;
import hxd.Event;
import h2d.Particles;
import motion.Actuate;
import motion.easing.Quad;
import h2d.SpriteBatch;
import tools.DynamicScene;
import hxd.Window;
import h2d.Bitmap;
import hxd.Res;
import h2d.Scene;
import h2d.Text;
import ui.TextButton;
import scene.arena.BattleArena;
import tools.ScreenTools as Screen;
    /**
    * Class to create a screen display of the main menu ( displayed when you start the game ).
    * You can insert all UI element that you want to display. 
    * You can find preBuild UI element in scene.gameUI
    */

class Menu extends DynamicScene  {
    private var scene:Scene;
    private var background:Bitmap;
    private var blueStarField:SpriteBatch;
    private var smokeGenerator:Particles;
    private var g:ParticleGroup;
    private var volcano:Bitmap;
    private var title:Text;
    private var playButton:TextButton;
    private var optionsButton:TextButton;
    private var multiButton:TextButton;

    /**
     * Create a new scene of the options menu
     * if you want to display it don't forget to change the current scene of the game with Game.instance.setScene( insert the new scene )
     */

    public function new() {
        super();
        background = new Bitmap(hxd.Res.projectBackground.toTile());

        volcano = new Bitmap(hxd.Res.volcano.toTile());

        blueStarField = new SpriteBatch(hxd.Res.blueStar.toTile());

        blueStarField.hasUpdate = true;
        blueStarField.hasRotationScale = true;
        for (i in 0...5) {
            var blueStar = new BatchElement(blueStarField.tile);
            var duration=0.5;
            var scale = 1.0;
            switch i {
                case 0:
                    duration = 0.5;
                    blueStar.scaleX = 0.5;
                    blueStar.scaleY = 0.5;
                    scale = 0.6;
                    
                case 1:
                    duration = 0.40;
                    blueStar.scaleX = 0.9;
                    blueStar.scaleY = 0.9;
                    scale = 0.95;
                case 2:
                    duration = 0.65;
                    blueStar.scaleX = 0.7;
                    blueStar.scaleY = 0.7;
                case 3:
                    duration = 0.45;
                    blueStar.scaleX = 0.55;
                    blueStar.scaleY = 0.55;
                    scale = 0.6;
                case 4:
                    duration = 0.35;
                    blueStar.scaleX = 0.75;
                    blueStar.scaleY = 0.75;
                    scale = 0.8;
            }
            
            Actuate.tween(blueStar, duration,  { scaleX: scale, scaleY: scale } ).ease(Quad.easeInOut).repeat().reflect();
            blueStarField.add(blueStar);
        }
        smokeGenerator = new Particles();
        g = new ParticleGroup(smokeGenerator);
        g.texture = hxd.Res.smoke.toTexture();
        g.nparts = 60;
        g.emitMode = Cone;
        g.emitAngle = -0.4;
        g.fadeIn = 0;
        g.life = 3.5;
        g.lifeRand = 0.15;

        smokeGenerator.addGroup(g);

        playButton = new TextButton(500, 250, "play");
        playButton.onClick = function (e:Event) {
            Game.currentScene = BattleArena.getInstance();
            Game.instance.setScene(Game.currentScene);
            Network.hostInstance = new Network();
            Network.hostInstance.init(5002);
             
            
        };
        optionsButton = new TextButton(500, 250, "join");
        optionsButton.onClick = function (e:Event) {
            Game.currentScene = BattleArena.getInstance();
            Game.instance.setScene(Game.currentScene);
            Network.clientInstance = new Network();  
            Network.clientInstance.init(5002,"78.229.249.245");
   
        };
        addChild(background);
        addChild(blueStarField);
        addChild(smokeGenerator);
        addChild(volcano);
        addChild(playButton);
        addChild(optionsButton);
        onResize();
    }

    /**
     * code below is executed each time the window is resized ( don't work on js )
     */


    override public function onResize() {
        background.tile.scaleToSize(Screen.w(), Screen.h());
        volcano.tile.scaleToSize(Screen.w(792/1920), Screen.h(230/1080));
        volcano.tile.setCenterRatio(0,1); //origin to bottom left
        volcano.y = Screen.h();
        g.size = Screen.w()/1920/3.555;
        g.speed = Screen.h(0.10);
        g.rebuild();
        blueStarField.tile.scaleToSize(Screen.w(0.025), Screen.w(0.025));
        blueStarField.tile.setCenterRatio();
        {
            var i = 0;
            for (blueStar in blueStarField.getElements()) {
                switch i {
                    case 0:
                        blueStar.x = Screen.w(0.75);
                        blueStar.y = Screen.h(0.25);
                    case 1:
                        blueStar.x = Screen.w(0.85);
                        blueStar.y = Screen.h(0.35);
                    case 2:
                        blueStar.x = Screen.w(0.65);
                        blueStar.y = Screen.h(0.10);
                    case 3:
                        blueStar.x = Screen.w(0.50);
                        blueStar.y = Screen.h(0.15);
                    case 4:
                        blueStar.x = Screen.w(0.55);
                        blueStar.y = Screen.h(0.20);
                }
                i++;
            }
        }
        smokeGenerator.x = Screen.w(0.20);
        smokeGenerator.y = Screen.h(0.95);
        playButton.onResize(250, 125);
        playButton.x = Screen.w(0.5)-playButton.width*0.5;
        playButton.y = Screen.h(0.3)-playButton.height*0.5;
        optionsButton.onResize(250, 125);
        optionsButton.x = Screen.w(0.5)-optionsButton.width*0.5;
        optionsButton.y = Screen.h(0.5)-optionsButton.height*0.5;
        
    }

    /**
    * code below is executed each time before a frame is generated
    * @param dt time beetwen the last frame and the current frame
    */

    override public function update(dt:Float) {

    }
        
}