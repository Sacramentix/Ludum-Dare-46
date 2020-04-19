package scene.arena;

import hxd.Timer;
import scene.arena.ui.Bundle;
import networking.Network;
import hxd.Window;
import h2d.Tile;
import h2d.Bitmap;
import scene.arena.layer.ArenaUI;
import scene.arena.layer.GameLayer;
import scene.arena.layer.GroundLayer;
import h2d.Text;
import h2d.Object;
import tools.DynamicScene;
import tools.ScreenTools as Screen;


/**
 * Class to create a screen display of the options menu
 * you can insert all UI element that you want to display. 
 * You can find preBuild UI element in scene.gameUI
 */

class BattleArena extends DynamicScene {
    
    public var lastTimeStamp:Float;

    public var isControlBlocked:Bool= false;

    public var gameLayer:GameLayer;
        public var groundLayer:Object;
        public var entityLayer:Object;
    public var uiBundle:Bundle;

    public var fps:Text;
    public var configID:Int;

    private static var instance:BattleArena;

    public static function getInstance():BattleArena {
        if (instance==null) {
            instance = new BattleArena();
            instance.init();
        }
        return instance;
    }
    
    private function new() {
        super();
    }
    public function init() {
        gameLayer = new GameLayer(this);
            groundLayer = new GroundLayer(gameLayer);
            entityLayer = new Object(gameLayer);
        uiBundle = new Bundle(this);
        onResize(); 
    }
    
    
    /**
     * code below is executed each time the window is resized ( don't work on js )
     */

    override public function onResize() {
        gameLayer.onResize();
        uiBundle.onResize();
        if (Network.hostInstance != null) Network.hostInstance.onResize();
        if (Network.clientInstance != null) Network.clientInstance.onResize();
    }

    /**
    * code below is executed each time before a frame is generated
    * @param dt time beetwen the last frame and the current frame
    */
    
    override public function update(dt:Float) {  
        if (Network.hostInstance != null) Network.hostInstance.update(dt);
        if (Network.clientInstance != null) Network.clientInstance.update(dt);
        
    }

    public function updatePerTick() {
       
    }
    
     
}