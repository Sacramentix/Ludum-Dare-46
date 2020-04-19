package scene.arena.ui;

import h3d.Vector;
import config.FontFolder;
import hxd.Window;
import h2d.Object;
import hxd.res.DefaultFont;
import scene.arena.ui.CooldownBox.CooldownBoxContainer;
import h2d.Text;


class Bundle extends Object {
    
    public var hp:Text;
    public var gold:Text;
    public var live:Text;
    public var cdContainer:CooldownBoxContainer;

    public function new(?parent:Object) {
        super(parent);
        cdContainer = new CooldownBoxContainer(this);
        cdContainer.x = 5;
        hp = new Text(FontFolder.pirata16, this);
        hp.x = cdContainer.getWidth() + 10;
        hp.y = (cdContainer.getHeight()-hp.textHeight)/2;
        hp.color = Vector.fromColor(0x80ff0000);
        hp.textAlign = Align.Left;
        hp.text = "oui";
        x=0;
        
    }

    public function getHeight() {
        return cdContainer.getHeight();
    }

    public function onResize() {
        cdContainer.onResize();
        y = Window.getInstance().height-getHeight();

    }


    

}