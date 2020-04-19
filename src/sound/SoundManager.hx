package sound;

import hxd.res.Sound;
import hxd.snd.Channel;


class SoundManager {

    private static var instance:SoundManager;
    public var musicChannel:Channel;
    public var musicList:Array<Sound>;
    public var sfxList:Array<Sound>;
    public var currentMusicID:Int = 0;

    public var musicVolume:Float = 1.0;
    public var sfxVolume:Float = 1.0;

    public var musicMuted:Bool;
    public var sfxMuted:Bool;


    public static function getInstance() {
        if (instance==null) instance = new SoundManager();
        return instance;
    }

    private function new() {
        musicList = new Array<Sound>();
        sfxList = new Array<Sound>();
        
    }

    public function trigger(id:Int) {
        try {
            var channel = sfxList[id].play(true);
            channel.loop = false;
        } catch(e:Dynamic) {

        }

        
    }

    
}