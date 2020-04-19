package game.hero;

import hxbit.Serializable;

class Stats implements Serializable {
    
    @:s public var moveSpeed:Float=100.0;
    @:s public var hitboxSize:Float=1.0;
    @:s public var maxHP:Float=750.0;
    @:s public var hp:Float=750.0;
    @:s public var damage:Float=100.0;
    @:s public var power:Float=100.0;
    @:s public var cdr:Float=0.0;
    @:s public var live:Int=3;
    @:s public var currentLive:Int=3;
    @:s public var knockback:Float=50;
    @:s public var level:Int=0;

    public function new() {  


    }


}