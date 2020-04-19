package game.hero;

import motion.easing.Linear;
import scene.arena.layer.GameLayer as Gl;
import motion.Actuate;

class Spells {
    
    public var hero:Hero;

    public var isBlow:Bool;

    public function new(hero:Hero) {
        this.hero = hero;
    }

    public function hammerBlow() {
        
    }

    public function cleanse() {
        
    }

    public function swapElement() {
        
    }

    public function purgeElement() {
        
    }

    public function dash() {
        
    }

    public function slowFlask() {
        
    }


}

enum abstract SpellID(Int) from Int to Int {
    var HammerBlow;
    var Cleanse;
    var SwapElement;
    var PurgeElement;
    var Dash;
    var SlowFlask;

}