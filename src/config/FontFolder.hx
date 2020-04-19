package config;

import h2d.Font;

/**
 * this class is init at the start of the game, it contains all font of the game.
 */

class FontFolder {

    public static var pirata128:Font;
    public static var pirata64:Font;
    public static var pirata16:Font;
    
    /**
     * called at the start of the game to initiate all font and adjust their size
     */

    public static function init() {
        
        pirata128 = hxd.Res.font.Pirata128.toFont();
        pirata128.resizeTo(128);
        pirata64 = hxd.Res.font.Pirata64.toFont();
        pirata64.resizeTo(64);
        pirata16 = hxd.Res.font.Pirata16.toFont();
        pirata16.resizeTo(16);
    }

}