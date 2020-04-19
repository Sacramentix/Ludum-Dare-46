package tools;

import h2d.Scene;

/**
 * Implement this interface to call app event on what ever you want
 */

interface SceneEvent   {
    public function update(dt:Float):Void;
    public function onResize():Void;

}

/**
 * extend this to have a scene that can update and resize
 */

//abstract
class DynamicScene extends Scene implements SceneEvent  {
    public function update(dt:Float):Void {
        
    }
    public function onResize():Void {

    }
    public function new() {
        super();
    }
}
