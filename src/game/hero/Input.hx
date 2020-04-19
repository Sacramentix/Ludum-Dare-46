package game.hero;

import config.KeybindConfig;
import game.hero.Spells.SpellID;
import hxd.Key as K;

class Input {

    public var hero:Hero;
    public var dashKey:Int = 84;
    public var dash:Bool;

    public function new(hero:Hero) {
        this.hero = hero;
        
  
    }

    public function update(dt:Float) {
        dash = K.isReleased(dashKey);
    }
}