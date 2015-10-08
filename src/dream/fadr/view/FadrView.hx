package dream.fadr.view;

import js.Browser.document;
import js.html.Element;
import haxe.Timer;
import dream.fadr.FadrSettings;

class FadrView {

    public var dom(default,null) : Element;
    public var palettes(default,null) : Array<ColorPalette>;
    public var palette(default,null) : ColorPalette;
    public var brightness(default,null) : Int;
    public var saturation(default,null) : Int;
    public var fadeDuration(default,null) : Int;
    public var changeInterval(default,null) : Int;
    public var currentColor(default,null) : String;

    var timer : Timer;
    var isFading : Bool;
    var nextColor : String;
    var colors : Array<String>;

    public function new( palettes : Array<ColorPalette>, settings : FadrSettings ) {

        this.palettes = palettes;
        this.brightness = settings.brightness;
        this.saturation = settings.saturation;
        this.fadeDuration = settings.fadeDuration;
        this.changeInterval = settings.changeInterval;

        isFading = false;
        currentColor = '#000';
        palette = getRandomColorPalette();
        colors = palette.colors.copy();

        dom = document.getElementById( 'fadr' );
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
        if( value <= 0 ) value = 1;
        this.changeInterval = value;
        startFade();
    }

    function getRandomColorPalette() : ColorPalette {
        return palettes[Std.int(Math.random()*palettes.length)];
    }

    function applyFadeDuration() {
        dom.style.transitionDuration = ((fadeDuration == 0 ) ? 1 : fadeDuration)+'ms';
    }

    function applyFilters() {
        //#if android
        //untyped dom.style.filter = 'saturate('+saturation+'%)';
        //untyped dom.style.webkitFilter = 'saturate('+saturation+'%)';
        //#else
        var str = 'brightness('+brightness+'%) saturate('+saturation+'%)';
        dom.style.filter = str;
        untyped dom.style.webkitFilter = str;
        //trace(str);
        //trace(untyped dom.style.webkitFilter);
        //#end
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
