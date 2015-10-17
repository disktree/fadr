package fadr;

import js.Browser.document;
import js.html.Element;
import haxe.Timer;

class View {

    public var element(default,null) : Element;

    public var fadeDuration(get,set) : Int;
    public var changeInterval(get,set) : Int;

    public var brightness(get,set) : Int;
    public var saturation(get,set) : Int;

    var _fadeDuration : Int;
    var _changeInterval : Int;
    var _brightness : Int;
    var _saturation : Int;

    var palettes : Array<ColorPalette>;
    //var palette(default,null) : ColorPalette;
    var isFading : Bool;
    var currentColor : String;
    var nextColor : String;
    var colors : Array<String>;
    var timer : Timer;

    public function new( palettes : Array<ColorPalette>, settings : SettingsData ) {

        this.palettes = palettes;
        this._fadeDuration = settings.fadeDuration;
        this._changeInterval = settings.changeInterval;
        this._brightness = settings.brightness;
        this._saturation = settings.saturation;

        isFading = false;
        currentColor = '#000';
        colors = getRandomColorPalette().colors.copy();

        element = document.getElementById( 'fadr' );
        element.addEventListener( 'transitionend', handleTransitionEnd, false );

        applyFilters();
        applyFadeDuration();
    }

    inline function get_fadeDuration() return _fadeDuration;
    function set_fadeDuration(v:Int) : Int {
        if( v <= 0 ) v = 1;
        _fadeDuration = v;
        applyFadeDuration();
        startFade();
        return v;
    }

    inline function get_changeInterval() return _changeInterval;
    function set_changeInterval(v:Int) : Int {
        if( v <= 0 ) v = 1;
        _changeInterval = v;
        startFade();
        return v;
    }

    inline function get_brightness() : Int return _brightness;
    function set_brightness(v:Int) : Int {
        _brightness = v;
        applyFilters();
        return v;
    }

    inline function get_saturation() : Int return _saturation;
    function set_saturation(v:Int) : Int {
        _saturation = v;
        applyFilters();
        return v;
    }

    public function start() {
        startFade();
    }

    public function stop() {
        if( timer != null ) timer.stop();
    }

    /*
    public function getSettings() : SettingsData {
        return {
            fadeDuration: _fadeDuration,
            changeInterval: _changeInterval,
            brightness: _brightness,
            saturation: _saturation,
            #if chrome
            //idleTimeout: _idleTimeout,
            #end
        };
    }
    */

    function startFade() {
        if( timer != null ) {
            timer.stop();
            timer = null;
        }
        isFading = true;
        nextColor = getRandomColor();
        element.style.backgroundColor = nextColor;
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

    function applyFadeDuration() {
        element.style.transitionDuration = _fadeDuration+'ms';
    }

    function applyFilters() {
        var str = 'brightness('+_brightness+'%) saturate('+_saturation+'%)';
        element.style.filter = str;
        untyped element.style.webkitFilter = str;
        #if web
        untyped element.style.mozFilter = str;
        #end
    }

    function getRandomColorPalette() : ColorPalette {
        return palettes[Std.int(Math.random()*palettes.length)];
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
            var palette = getRandomColorPalette();
            colors = palette.colors.copy();
        }
        return color;
    }
}
