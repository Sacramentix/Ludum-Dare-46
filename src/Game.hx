import hxd.Window;
import scene.Menu;
import tools.DynamicScene;
import config.FontFolder;
import config.KeybindConfig;
import networking.Network;

/**
 * Main class of the game launched when you start the program
 */

class Game extends hxd.App
{
    
    /** current scene displayed on the screen **/
    public static var currentScene:DynamicScene;
    /** instance of the game used to change the current scene **/
    public static var instance:Game;
    

    static function main()
    {
        
        //SoundManager.init();
        instance = new Game();
        
    }
 

    /**
     * code below is executed 1 time when you start the app
     */

    override function init() {   
        
        hxd.Res.initLocal();
        //Window.getInstance().setFullScreen(true);
        
        FontFolder.init(); // init all font
        KeybindConfig.fromFolder();

        currentScene = new scene.Menu();
        this.setScene2D(currentScene);
        
    }

    /**
     * code below is executed each time before a frame is generated
     * @param dt time beetwen the last frame and the current frame
     */

    override function update(dt:Float) {
		
            currentScene.update(dt);

    }

    /**
     * code below is executed each time the window is resized ( don't work on js )
     */

    override function onResize() {

        currentScene.onResize();

    }
    
}
