package networking;

import scene.arena.BattleArena;
import tools.DynamicScene.SceneEvent;
import game.Hero;
import hxd.Window;


class Network implements SceneEvent {

	public var arenaPosition : Position;
    public var heroList:Array<Hero>;
    
	public var uid : Int=0;

    public var host : hxd.net.SocketHost;

    public static var clientInstance:Network;

    public static var hostInstance:Network;
    public function new() {
        
    }
	public function init(PORT:Int, ?HOST:String) {
		heroList = new Array<Hero>();
		host = new hxd.net.SocketHost();
		host.setLogger(function(msg) log(msg));

        if (HOST == null) {
            host.wait("0.0.0.0", PORT, function(c) {
                log("Client Connected");
			});
			host.onMessage = function(c,uuid:Int) {
                log("Client identified ("+uuid+")");
				var hero = new Hero(uuid);
				c.ownerObject = hero;
				c.sync();
			};
			log("Server Started");
            start();
			
        } else {
            
			// we could not start the server
			log("Connecting");

			arenaPosition = Top;
			uid = 1 + Std.random(1000);
			host.connect(HOST, PORT, function(b) {
				if( !b ) {
					log("Failed to connect to server");
					return;
				}
				log("Connected to server");
				host.sendMessage(uid);
			});

			host.onMessage = function(c,uuid:Int) {
                log("Client identified ("+uuid+")");
				var hero = new Hero(uuid);
				c.ownerObject = hero;
				c.sync();
			};
		}
    }

		

	public function log( s : String, ?pos : haxe.PosInfos ) {
		pos.fileName = (host.isAuth ? "[S]" : "[C]") + " " + pos.fileName;
		haxe.Log.trace(s, pos);
	}

	function start() {
		var hero = new Hero();
		host.self.ownerObject = hero;
		log("Live");
		host.makeAlive();
	}


	public function update(dt:Float) {
        try {
			for (hero in heroList) {
				if (hero != null) hero.update(dt);
			} 
        } catch(e:Dynamic) {
            trace(e);
        }

		host.flush();
    }
    public function onResize() {
        try {
            for (hero in heroList) {
				if (hero != null) hero.onResize();
			} 
        } catch(e:Dynamic) {
            trace(e);
        }
        
    }
}