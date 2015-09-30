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
    var animation : Dynamic;
    var timer : Timer;
    var isFading : Bool;

    public function new( brightness = 100, saturation = 100, fadeDuration = 1000, changeInterval = 1000 ) {

        this.brightness = brightness;
        this.saturation = saturation;
        this.fadeDuration = fadeDuration;
        this.changeInterval = changeInterval;

        dom = document.getElementById( 'fadr' );

        applyFilters();

        isFading = false;
        currentColor = '#000';
        palette = getRandomColorPalette();
    }

    public function start() {
        startFade();
    }

    public function stop() {
        if( timer != null ) timer.stop();
        if( animation != null ) animation.cancel();
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

        if( isFading ) {
            animation.cancel();
        } else {
            timer.stop();
        }
        startFade();
    }

    public function setChangeInterval( value : Int ) {

        this.changeInterval = value;

        if( isFading ) {
            animation.cancel();
        } else {
            timer.stop();
        }
        startFade();
    }

    function applyFilters() {
        untyped dom.style.webkitFilter = 'brightness('+(brightness/100)+') saturate('+saturation+'%)';
    }

    function startFade() {

        isFading = true;

        var nextColor = getRandomColor();
        animation = untyped dom.animate( [
                { backgroundColor:currentColor },
                { backgroundColor:nextColor }
            ],
            { duration:fadeDuration, fill:'both' }
        );
        animation.onfinish = function(e){
            dom.style.backgroundColor = currentColor = nextColor;
            e.target.cancel();
            handleFadeComplete();
        }
    }

    function handleFadeComplete() {
        animation = null;
        isFading = false;
        timer = new Timer( changeInterval );
        timer.run = handleTimeout;
    }

    function handleTimeout() {
        timer.stop();
        startFade();
    }

    function getRandomColor() : String {
        return palette.colors[Std.int(Math.random()*palette.colors.length)];
    }

}
