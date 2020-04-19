package scene.arena.layer;

import h2d.col.Point;
import h2d.Object;
import h2d.Tile;
import h2d.Bitmap;

import tools.ScreenTools as Screen;

class GameLayer extends Object {
    
    public var bg:Bitmap;

    private var instance:GameLayer;

    public static var unit(get, never):Float;

    private static function get_unit() {
        if (Screen.h()*1.75>=Screen.w()) {
            return Screen.w(0.05)/1.75;
        } else {
            return Screen.h(0.05);

        }
    }

    public function new(?parent:Object) {
        super(parent);
        bg = new Bitmap(Tile.fromColor(0xdddddd,50,50), this);
    }

    public function onResize() {
        if (Screen.h()*1.75>=Screen.w()) {
            bg.tile.scaleToSize(Screen.w(), Screen.w()/1.75);
            bg.x = 0;
            bg.y = (Screen.h()-Screen.w()/1.75)/2;
        } else {
            bg.tile.scaleToSize(Screen.h()*1.75, Screen.h());
            bg.y = 0;
            bg.x = (Screen.w()-Screen.h()*1.75)/2;
        }
    }

    public static function globalToArena(p:Point):Point {
        return p;
    }
    public static function arenaToGlobal(p:Point):Point {
        return p;
    }
    public static function globalToArenaX(x:Float):Float {
        if (Screen.h()*1.75>=Screen.w()) {
            return x/Screen.w();
        } else {
            return (x-(Screen.w()-Screen.h()*1.75)/2)/(Screen.h()*1.75);
        }
    }
    public static function arenaToGlobalX(x:Float):Float {
        if (Screen.h()*1.75>=Screen.w()) {
            return x*Screen.w();
        } else {
            return x*(Screen.h()*1.75)+(Screen.w()-Screen.h()*1.75)/2;
        }
    }
    public static function globalToArenaY(y:Float):Float {
        if (Screen.h()*1.75>=Screen.w()) {
            return (y-(Screen.h()-Screen.w()/1.75)/2)/(Screen.w()/1.75);
        } else {
            return y/Screen.h();

        }
    }
    public static function arenaToGlobalY(y:Float):Float {
        if (Screen.h()*1.75>=Screen.w()) {
            return y*(Screen.w()/1.75)+(Screen.h()-Screen.w()/1.75)/2;
        } else {
            return y*Screen.h();
        }
    }


}