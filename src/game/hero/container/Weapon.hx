package game.hero.container;

import h2d.Graphics;
import h2d.Tile;
import h2d.Object;
import tools.DynamicScene.SceneEvent;
import h2d.Bitmap;
import scene.arena.layer.GameLayer as Gl;

class Weapon extends Bitmap implements SceneEvent {
    
    #if debug
    public var graphic:Graphics;
    #end

    public function new(?parent:Object) {
        //var sprite = hxd.Res.stalker.harpoon.toTile();
        var sprite = Tile.fromColor(0xff0000);
        sprite.scaleToSize(Gl.unit*0.5, Gl.unit*0.5);
        sprite.setCenterRatio();
        super(sprite, parent);
        graphic = new Graphics(this);
    }

    public function onResize() {
        tile.scaleToSize(Gl.unit*0.5, Gl.unit*0.5);
        tile.setCenterRatio(-0.5, 0.5);
    }

    public function update(dt:Float) {
        graphic.clear();
        graphic.beginFill(0x00ff00, 0.5);
        graphic.drawCircle(Gl.unit*0.5, 0, Gl.unit*0.5);
        graphic.endFill();
    }
    

}