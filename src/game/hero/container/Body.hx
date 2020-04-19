package game.hero.container;

import h2d.Object;
import tools.DynamicScene.SceneEvent;
import h2d.Bitmap;
import h2d.Tile;
import scene.arena.layer.GameLayer as Gl;

class Body extends Bitmap implements SceneEvent {
    

    public function new(?parent:Object) {
        //var sprite = hxd.Res.stalker.body.toTile();
        var sprite = Tile.fromColor(0x0000ff);
        sprite.scaleToSize(Gl.unit*0.5, Gl.unit*0.5);
        sprite.setCenterRatio();
        super(sprite, parent);
    }

    public function onResize() {
        tile.scaleToSize(Gl.unit*0.5, Gl.unit*0.5);
        tile.setCenterRatio();
    }

    public function update(dt:Float) {
        
    }
    

}