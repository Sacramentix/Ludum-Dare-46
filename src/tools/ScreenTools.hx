package tools;

import h2d.col.Point;
import h2d.Bitmap;
import h2d.Object;
import hxd.Window;

class ScreenTools {

    /*public static function isOnScreen(subject:Object):Bool {
        return isPointOnScreen(subject.localToGlobal());
    }

    public static function isYOnScreen(subject:Object):Bool {
        return isYOnScreen(subject.localToGlobal());
    }

    public static  function isYOnScreen(p:Point):Bool {
        if ( p.y > 0 && p.y < Window.getInstance().height ) return true;
        else return false;
    }

    public static  function isPointOnScreen(p:Point):Bool {
        if ( p.x > 0 && p.x < Window.getInstance().width && p.y > 0 && p.y < Window.getInstance().height ) return true;
        else return false;
    }*/
    // return pourcent of screen height
    public static inline function h(pourcent:Float=1):Float {
        return Window.getInstance().height*pourcent;
    }
    // return pourcent of screen width
    public static inline function w(pourcent:Float=1):Float {
        return Window.getInstance().width*pourcent;
    }
    // return pourcent of screen height rounded to int
    public static inline function inth(pourcent:Float=1):Int {
        return  Std.int(Window.getInstance().height*pourcent);
    }
    // return pourcent of screen width rounded to int
    public static inline function intw(pourcent:Float=1):Int {
        return Std.int(Window.getInstance().width*pourcent);
    }


}