package fadr.chrome;

import js.Browser.document;
import js.html.Element;
import fadr.view.Slider;

class SettingsMenu {

    public dynamic function onIdleTimeoutChange( value : Int ) {}
    public dynamic function onBrightnessInput( value : Int ) {}
    public dynamic function onBrightnessChange( value : Int ) {}
    public dynamic function onSaturationInput( value : Int ) {}
    public dynamic function onSaturationChange( value : Int ) {}
    public dynamic function onFadeDurationChange( value : Int ) {}
    public dynamic function onChangeIntervalChange( value : Int ) {}
    public dynamic function onPowerLevelChange( value : chrome.Power.Level ) {}

    public var isMouseOver(default,null) = false;
    public var isVisible(default,null) = false;

    var dom : Element;
    var idleTimeoutInput : Slider;
    var powerDisplay : Element;
    var powerSystem : Element;
    var powerLevel : chrome.Power.Level;
    var fadeDurationInput : Slider;
    var changeIntervalInput : Slider;
    var brightnessInput : Slider;
    var saturateInput : Slider;

    public function new( settings : SettingsData ) {

        dom = document.getElementById( 'settings' );

        dom.onmouseover = function(_) isMouseOver = true;
        dom.onmouseout = function(_) isMouseOver = false;

        idleTimeoutInput = new Slider( 'idle-timeout', settings.idleTimeout, ' secs' );
        idleTimeoutInput.onChange = function(v) onIdleTimeoutChange(v);

        powerDisplay = document.getElementById( 'power-display' );
        powerDisplay.addEventListener( 'click', function(e){
            onPowerLevelChange( (powerLevel == display) ? null : display );
        }, false );

        powerSystem = document.getElementById( 'power-system' );
        powerSystem.addEventListener( 'click', function(e){
            onPowerLevelChange( (powerLevel == system) ? null : system );
        }, false );

        setPowerLevel( settings.power );

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

    public inline function setIdleTimeout( v : Int ) {
        idleTimeoutInput.setValue(v);
    }

    public inline function setFadeDuration( v : Int ) {
        fadeDurationInput.setValue(v);
    }

    public inline function setChangeInterval( v : Int ) {
        changeIntervalInput.setValue(v);
    }

    public function setPowerLevel( level : chrome.Power.Level ) {
        this.powerLevel = level;
        switch level {
        case display:
            powerDisplay.style.textDecoration = 'none';
            powerSystem.style.textDecoration = 'line-through';
        case system:
            powerDisplay.style.textDecoration = 'line-through';
            powerSystem.style.textDecoration = 'none';
        case null:
            powerDisplay.style.textDecoration = powerSystem.style.textDecoration = 'line-through';

        }
    }

}
