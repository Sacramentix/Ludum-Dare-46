package game.hero;

import tools.DynamicScene.SceneEvent;
import h2d.Object;
import game.hero.container.Body;
import game.hero.container.Weapon;
import game.hero.container.Battery;
import scene.arena.layer.GameLayer as Gl;

class Container extends Object implements SceneEvent {

    public var body:Body;
    public var weapon:Weapon;
    public var battery:Battery;

    public var hero:Hero;

    public function new(hero:Hero, parent:Object) {
        super(parent);
        body = new Body(this);
        weapon = new Weapon(this);
        battery = new Battery(parent);
        battery.x = -Gl.unit*2;

        this.hero = hero;
    }

    public function onResize() {
        body.onResize();
        weapon.onResize();
        battery.onResize();
    }

    public function update(dt:Float) {
        body.update(dt);
        weapon.update(dt);
    }

}