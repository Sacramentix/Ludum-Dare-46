package scene.arena.layer;

import h2d.Object;
import scene.arena.ui.Bundle;

import tools.ScreenTools as Screen;

class ArenaUI {

    public var topUI:Bundle;
    public var botUI:Bundle;

    public function new(?parent:Object) {
        topUI = new Bundle(parent);
        topUI.x = 5;
        topUI.y = 5;
        botUI = new Bundle(parent);
        botUI.x = 5;
        botUI.y = Screen.h()-botUI.getHeight()-5;
    }

    public function onResize() {
        botUI.y = Screen.h()-botUI.getHeight()-5;
    }

}

