package game.hero.container;

import motion.Actuate;
import h2d.Object;
import tools.DynamicScene.SceneEvent;
import h2d.Bitmap;
import h2d.Tile;
import scene.arena.layer.GameLayer as Gl;

class Battery extends Bitmap implements SceneEvent {
    

    public function new(?parent:Object) {
        //var sprite = hxd.Res.stalker.body.toTile();
        var sprite = Tile.fromColor(0x00ffff);
        sprite.scaleToSize(Gl.unit, Gl.unit);
        sprite.setCenterRatio();
        super(sprite, parent);
        Actuate.tween(this, 2, { rotation: rotation+Math.PI}).repeat();
        
    }

    public function onResize() {
        tile.scaleToSize(Gl.unit, Gl.unit);
        tile.setCenterRatio();
    }

    public function update(dt:Float) {
        
    }
    

}