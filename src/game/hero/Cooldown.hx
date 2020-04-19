package game.hero;   

import scene.arena.ui.Bundle;
import game.hero.Spells.SpellID;
import hxbit.Serializable;


class Cooldown implements Serializable {

    @:s public var spells:Array<SpellCD>;
    public var stats:Stats;
    public var uiBundle:Bundle;

	public function new() {
        var listOfCdSpell = [1.0, 30.0, 8.0, 15.0, 8.0, 20.0];
        spells = new Array<SpellCD>();
		for (i in 0...10) {
            var newSpell = new SpellCD(listOfCdSpell[i]);
            spells.push(newSpell);
        }
        
	}

    public function used(spell:SpellID) {
        spells[spell].isReady = false;
        spells[spell].time = spells[spell].cd*(1-stats.cdr);
    }

	public function update(dt:Float) {
        var i=0;
        for (spell in spells) {
            if (!spell.isReady) {
                spell.time -= dt;
                if (spell.time <= 0) spell.isReady = true;
                var time:RFloat = spell.time;
                try {
                    uiBundle.cdContainer.spellBoxList[i].label.text = Std.string(time);
                } catch (e:Dynamic) {
                }

            }
            i++;
        } 
    }


}

class SpellCD implements Serializable {

    @:s public var cd:Float;
	@:s public var time:Float;
    @:s public var isReady:Bool;
    @:s public var isUnlocked:Bool;

    public function new(spellCD:Float=0.0) {
        cd = spellCD;
        time = 0;
        isReady = true;
    }

}

abstract RFloat(Float) from Float {
    inline function new(value : Float)  
    this = value;

    // The following rounds the result whenever converted to a Float
    @:to inline public function toFloat():Float  {
        return roundFloat(this);
    }
    
    @:to inline public function toString():String {
        return Std.string(toFloat());
    }
    // The number of zeros in the following valuer
    // corresponds to the number of decimals rounding precision
    static inline var multiplier = 10;
        
    static inline function roundFloat(value:Float):Float
        return Math.round(value * multiplier) / multiplier;
}