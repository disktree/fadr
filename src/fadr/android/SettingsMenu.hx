package fadr.android;

import js.Browser.document;
import js.html.Element;
import fadr.view.Slider;

class SettingsMenu {

    public dynamic function onBrightnessInput( value : Int ) {}
    public dynamic function onBrightnessChange( value : Int ) {}
    public dynamic function onSaturationInput( value : Int ) {}
    public dynamic function onSaturationChange( value : Int ) {}
    public dynamic function onFadeDurationChange( value : Int ) {}
    public dynamic function onChangeIntervalChange( value : Int ) {}

    public var isMouseOver(default,null) = false;
    public var isVisible(default,null) = false;

    var dom : Element;
    var fadeDurationInput : Slider;
    var changeIntervalInput : Slider;
    var brightnessInput : Slider;
    var saturateInput : Slider;

    public function new( settings : SettingsData ) {

        dom = document.getElementById( 'settings' );

        dom.onmouseover = function(_) isMouseOver = true;
        dom.onmouseout = function(_) isMouseOver = false;

        fadeDurationInput = new Slider( 'fade-duration', settings.fadeDuration, ' ms' );
        fadeDurationInput.onChange = function(v) onFadeDurationChange(v);

        changeIntervalInput = new Slider( 'change-interval', settings.changeInterval, ' ms' );
        changeIntervalInput.onChange = function(v) onChangeIntervalChange(v);

        brightnessInput = new Slider( 'brightness', settings.brightness, '%' );
        brightnessInput.onInput = function(v) onBrightnessInput(v);
        brightnessInput.onChange = function(v) onBrightnessChange(v);

        saturateInput = new Slider( 'saturation', settings.saturation, '%' );
        saturateInput.onInput = function(v) onSaturationInput(v);
        saturateInput.onChange = function(v) onSaturationChange(v);
    }

    public function show() {
        dom.style.visibility = 'visible';
        isVisible = true;
    }

    public function hide() {
        dom.style.visibility = 'hidden';
        isVisible = false;
    }

    public inline function toggle() {
        isVisible ? hide() : show();
    }

    public inline function setBrightness( v : Int ) {
        brightnessInput.setValue(v);
    }

    public inline function setSaturation( v : Int ) {
        saturateInput.setValue(v);
    }

    public inline function setFadeDuration( v : Int ) {
        fadeDurationInput.setValue(v);
    }

    public inline function setChangeInterval( v : Int ) {
        changeIntervalInput.setValue(v);
    }

}
