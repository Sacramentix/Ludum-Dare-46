package ui;

import h2d.Interactive;
import h2d.Tile;
import h2d.Text;
import hxd.Event;
import h2d.Object;
import h2d.RenderContext;

class TextButton extends Interactive {

    public var label:Text;

    private var bg:Tile;
    private var hover:Tile;
    private var down:Tile;
    
    private var pressed:Bool;
  
    public function new(w:Float = -1, h:Float = -1, text:String, ?parent:Object) {

        super(w, h, parent);
        label = new Text(hxd.res.DefaultFont.get(), this);
        label.textAlign = Align.Center;
        label.text = text;
        label.x = 0;
        label.color.setColor(0xffffffff);
        
        bg = hxd.Res.button.toTile();
        hover = hxd.Res.buttonHover.toTile();
        down = hxd.Res.button.toTile();

        onResize(w, h);
        
    }

    public function onResize(w:Float, h:Float) {
        bg.scaleToSize(w, h);
        hover.scaleToSize(w, h);
        down.scaleToSize(w, h);
        label.font.resizeTo(Std.int(h*0.1));
        label.maxWidth = w;
        label.y = (h - label.textHeight) / 2;
        width = w;
        height = h;

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