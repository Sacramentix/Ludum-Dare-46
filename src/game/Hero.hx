package game;

import hxd.Window;
import scene.arena.ui.Bundle;
import networking.Network;
import scene.arena.BattleArena;
import hxd.Timer;
import motion.easing.Linear;
import scene.arena.layer.GameLayer as Gl;
import h2d.Tile;
import h2d.Object;
import h2d.Bitmap;
import motion.Actuate;
import hxbit.NetworkSerializable;
import hxd.Key as K;
import game.hero.Cooldown;
import game.hero.Stats;
import game.hero.Container;
import game.hero.Spells;
import game.hero.Input;
import hxd.Key as K;

class Hero implements NetworkSerializable  {
    
    @:s public var uid:Int;
    @:s public var x(default, set):Float;//arena position between 0 and 1 can be convert to global positon with static method in Gl
        public function set_x(v:Float) {
            networkLocalChange(function() {
                if (v<0) v = 0;
                if (v>1) v = 1;
                if (container != null) updateGlobalPosition();
            });
            return x = v;
        }
    @:s public var y(default, set):Float;
        public function set_y(v:Float) {
            networkLocalChange(function() {
                if (v<0) v = 0;
                if (v>1) v = 1;
                if (container != null) updateGlobalPosition();
            });
            return y = v;
        }
    @:s public var rotation:Float;//in Rad

    public var uiBundle:Bundle;
    
    public var container:Container;
    public var cooldown:Cooldown;
    @:s public var stats:Stats;
    public var spells:Spells;
    public var input:Input;

    var net:Network;

    public var spawned:Bool;

    public function new(uuid:Int=0) {
        this.uid = uuid;
        stats = new Stats();
        init(); 
        x = 0.5;
        y = 0.5;
    }

    public function init() {
        if(Network.hostInstance != null ) {
			net = Network.hostInstance;
        } else if (Network.clientInstance != null) {
            net = Network.clientInstance;
        }
        enableReplication = true;
        container = new Container(this, BattleArena.getInstance().entityLayer);
        input = new Input(this);
        spells = new Spells(this);
        cooldown = new Cooldown();
        cooldown.spells[HammerBlow].isUnlocked = true;
        

        if (net.heroList.indexOf(this) == -1) {
            net.heroList.push(this);
        }
		if( uid == net.uid ) {
            
            net.host.self.ownerObject = this;
            uiBundle = BattleArena.getInstance().uiBundle;
            cooldown.uiBundle = uiBundle;
            
        }        
        cooldown.stats = stats;
        onResize();
        updateGlobalPosition();




    }

    public function networkAllow( op : hxbit.NetworkSerializable.Operation, propId : Int, client : hxbit.NetworkSerializable ) : Bool {
		return client == this;
	}

    public function alive() {
        init();
		// refresh bmp

	}

    public function update(dt:Float) {
        cooldown.update(dt);
        if (this == net.host.self.ownerObject) {
            var mx = Window.getInstance().mouseX;
            var my = Window.getInstance().mouseY;
            input.update(dt);
            if (input.dash) dash(mx, my);
            if (K.isReleased(K.MOUSE_LEFT)) hammerBlow();
            if (K.isDown(K.MOUSE_RIGHT)) moveTo(mx, my);
  
        }

        updateGlobalPosition(); 
        container.update(dt);
    }

    @:rpc(immediate) public function moveTo(mx:Float, my:Float) {
        networkLocalChange(function() {
        var dx = Gl.globalToArenaX(mx)-x;
        var dy = Gl.globalToArenaY(my)-y;
        var angle = Math.atan2(dy, dx);
        x += stats.moveSpeed*Timer.tmod*Math.cos(angle)/25000;
        y += stats.moveSpeed*Timer.tmod*Math.sin(angle)/25000;
        rotation = angle;
        });
    }

    @:rpc(immediate) public function dash(mx:Float, my:Float) {
        networkLocalChange(function() {
        var dx = Gl.globalToArenaX(mx)-x;
        var dy = Gl.globalToArenaY(my)-y;
        var angle = Math.atan2(dy, dx);
        Actuate.tween(this, 0.3, {x: x+stats.moveSpeed*Math.cos(angle)/500});
        Actuate.tween(this, 0.3, {y: y+stats.moveSpeed*Math.sin(angle)/500});
        rotation = angle;
        });
    }

    @:rpc(immediate) public function hammerBlow() {
        networkLocalChange(function() {
            container.weapon.rotation = -1;
            Actuate.tween(this.container.weapon, 0.3, {rotation: 1});
            spells.isBlow = true;
        });
    }


    public function onResize() {
        updateGlobalPosition(); 
        container.onResize();
    }

    private function updateGlobalPosition() {
        container.x = Gl.arenaToGlobalX(x);
        container.y = Gl.arenaToGlobalY(y);
        container.rotation = rotation;
    }



}
abstract Direction(Bool) from Bool to Bool {
    inline function new(value : Bool)  
    this = value;

    @:to inline public function toInt():Int  {
        return if(this) 1 else -1;
    }
    @:from inline static public function fromInt(i:Int):Direction  {
        return if(i >= 0) true else false;
    }

    @:to inline public function toBool():Bool  {
        return if(this) true else false;
    }

}
enum abstract Position(Bool) {
    var Top = true;
    var Bot = false;
}
