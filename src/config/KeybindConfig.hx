package config;

#if !js
import sys.io.FileInput;
import sys.io.FileOutput;
import sys.FileSystem;
import sys.io.File;
import haxe.io.BytesOutput;
import haxe.io.Bytes;
#end

typedef Keybind = {

        var topPlayer:PlayerKeybind;
        var botPlayer:PlayerKeybind;
        var pause:Int;

    }

    typedef PlayerKeybind = {

        var swapDirectionKey:Int;
        var grabKey:Int;
        var ghostKey:Int;
        var dashKey:Int;
        var ultKey:Int;
        var flashKey:Int;
        var item0Key:Int;
        var item1Key:Int;
        var item2Key:Int;
        var item3Key:Int;
        var item4Key:Int;
        var item5Key:Int;

    }


class KeybindConfig {

    public static var list:Array<Keybind>;
    public static var currentKeybindID:Int = 0;//id of selected keybind config used in getCurrent()

#if js

    /**
     * Load every keybind config from the folder keybind and store them in the static list KeybindConfig.list
     */

    public static function fromFolder() {
        list = new Array<Keybind>();
        for (file in FileSystem.readDirectory("keybind")) {
			var json = File.read("keybind\\" + file);
            var data = json.readAll();
            var keybind:Keybind = haxe.Json.parse(data.getString(0,data.length));
            list.push(keybind);
        }
    }

#end

#if !js

    public static function fromFolder() {
        list = new Array<Keybind>();
        var playerkeyBot:PlayerKeybind = {
            dashKey:99,
            flashKey:110,
            ghostKey:98,
            grabKey:97,
            item0Key:103,
            item1Key:104,
            item2Key:105,
            item3Key:100,
            item4Key:101,
            item5Key:102,
            swapDirectionKey:96,
            ultKey:108
        };
        var playerkeyTop:PlayerKeybind = {
            dashKey:69,
            flashKey:70,
            ghostKey:90,
            grabKey:65,
            item0Key:49,
            item1Key:50,
            item2Key:51,
            item3Key:52,
            item4Key:53,
            item5Key:54,
            swapDirectionKey:83,
            ultKey:82
        };
        var keybind:Keybind = {
            topPlayer:playerkeyTop,
            botPlayer:playerkeyBot,
            pause:27
        };
        list.push(keybind);
    }
#end

    /**
     * @return the keybind config of the list at the @var currentKeybindID
     */

    public static function getCurrent():Keybind {
        return list[currentKeybindID];
    }


}
