package scene.arena.ui;

import hxd.Window;
import game.hero.Spells.SpellID;
import h2d.Flow;
import hxd.Event;
import h2d.RenderContext;
import config.FontFolder;
import h2d.Text;
import h2d.Object;
import h2d.Tile;
import h2d.Interactive;


class CooldownBox extends Interactive {

    public var bg:Tile;
    public var hover:Tile;
    public var down:Tile;

    private var pressed:Bool;

    public var label:Text;

    public function new(bg:Tile, size:Int=50, ?parent:Object) {
        super(size,size);
        this.bg = bg;
        hover = bg;
        down = bg;
        label = new Text(FontFolder.pirata16,this);
        label.textAlign = Right;
        label.maxWidth = 50;
        label.x = 0;
        label.y = 30;
        label.text = "10.0";
    }
    
    override private function draw(ctx:RenderContext) {
        if (isOver())
        {
        emitTile(ctx, pressed ? down : hover);
        }
        else 
        {
        emitTile(ctx, pressed ? hover : bg);
        }
    }
    
    override public function handleEvent(e:Event) {
        if (e.kind == EventKind.EPush)
        {
        pressed = true;
        }
        else if (e.kind == EventKind.ERelease || e.kind == EventKind.EReleaseOutside)
        {
        pressed = false;
        }
        super.handleEvent(e);
    }

}

class CooldownBoxContainer extends Flow {

    public var spellBoxList:Array<CooldownBox>;

    private var boxSize:Int=50;

    public function new(?parent:Object) {
        super(parent);
        padding = 5;
        horizontalSpacing= 15;
        debug = true;
        minHeight = paddingBottom+paddingTop+boxSize;
        maxHeight = paddingBottom+paddingTop+boxSize;
        minWidth = paddingRight+paddingLeft+5*boxSize+4*horizontalSpacing;
        maxWidth = Window.getInstance().width;
        backgroundTile = Tile.fromColor(0x121212, 0.25);
        spellBoxList = new Array<CooldownBox>();
        for (i in 0...5) {
            var box =  new CooldownBox(getSpellTile(i));
            spellBoxList.push(box);
            this.addChild(box);
        }
        needReflow = true;

    }
    public function getWidth():Float {
        return paddingRight+paddingLeft+5*boxSize+4*horizontalSpacing;
    }
    public function getHeight():Float {
        return paddingBottom+paddingTop+boxSize;
    }
    public function onResize() {
        
    }

    public function getSpellTile(spell:SpellID):Tile {
        switch spell {
            case HammerBlow:
                return Tile.fromColor(0x00ff00,boxSize,boxSize,0.25);
            case Dash:
                return Tile.fromColor(0x0000ff,boxSize,boxSize,0.25);
            default:
                return Tile.fromColor(0x00ff00,boxSize,boxSize,0.25);
        }

    }

}