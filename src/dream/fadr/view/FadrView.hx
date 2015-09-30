package dream.fadr.view;

import js.Browser.document;
import js.html.Element;
import haxe.Timer;

@:build(dream.fadr.macro.BuildFadrView.build())
class FadrView {

    static inline function getRandomColorPalette() : ColorPalette {
        return COLORS[Std.int(Math.random()*COLORS.length)];
    }

    ////////////////////////////////////////////////////////////////////////////

    public var palette(default,null) : ColorPalette;
    public var brightness(default,null) : Int;
    public var saturation(default,null) : Int;
    public var fadeDuration(default,null) : Int;
    public var changeInterval(default,null) : Int;
    public var currentColor(default,null) : String;

    var dom : Element;
    var timer : Timer;
    var isFading : Bool;
    var nextColor : String;
    var colors : Array<String>;

    public function new( brightness = 100, saturation = 100, fadeDuration = 1000, changeInterval = 1000 ) {

        this.brightness = brightness;
        this.saturation = saturation;
        this.fadeDuration = fadeDuration;
        this.changeInterval = changeInterval;

        isFading = false;
        currentColor = '#000';
        palette = getRandomColorPalette();
        colors = palette.colors.copy();

        dom = document.getElementById( 'fadr' );
        //dom.style.transitionProperty = ' background-color';
        applyFilters();
        applyFadeDuration();
        dom.addEventListener( 'transitionend', handleTransitionEnd );
    }

    public function start() {
        startFade();
    }

    public function stop() {
        if( timer != null ) timer.stop();
    }

    public function setBrightness( value : Int ) {
        this.brightness = value;
        applyFilters();
    }

    public function setSaturation( value : Int ) {
        this.saturation = value;
        applyFilters();
    }

    public function setFadeDuration( value : Int ) {
        this.fadeDuration = value;
        applyFadeDuration();
        startFade();
    }

    public function setChangeInterval( value : Int ) {
        this.changeInterval = value;
        startFade();
    }

    function applyFadeDuration() {
        dom.style.transitionDuration = ((fadeDuration == 0 ) ? 1 : fadeDuration)+'ms';
    }

    function applyFilters() {
        untyped dom.style.webkitFilter = 'brightness('+(brightness/100)+') saturate('+saturation+'%)';
    }

    function startFade() {
        if( timer != null ) {
            timer.stop();
            timer = null;
        }
        isFading = true;
        nextColor = getRandomColor();
        dom.style.backgroundColor = nextColor;
    }

    function handleTransitionEnd(e) {
        isFading = false;
        currentColor = nextColor;
        timer = new Timer( changeInterval );
        timer.run = handleTimeout;
    }

    function handleTimeout() {
        startFade();
    }

    function getRandomColor() : String {
        var color : String = null;
        var i : Int = null;
        while( true ) {
            i = Std.int( Math.random() * colors.length );
            color = colors[i];
            if( color != currentColor )
                break;
        }
        colors.splice( i, 1 );
        if( colors.length == 0 ) {
            palette = getRandomColorPalette();
            colors = palette.colors.copy();
        }
        return color;
    }

}
