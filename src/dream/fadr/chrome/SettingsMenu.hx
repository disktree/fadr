package dream.fadr.chrome;

import js.Browser.document;
import js.html.Element;
import dream.fadr.view.Slider;

class SettingsMenu {

    public dynamic function onIdleTimeoutInput( value : Int ) {}
    public dynamic function onBrightnessInput( value : Int ) {}
    public dynamic function onSaturationInput( value : Int ) {}
    public dynamic function onFadeDurationInput( value : Int ) {}
    public dynamic function onChangeIntervalInput( value : Int ) {}
    public dynamic function onPowerLevelChange( value : chrome.Power.Level ) {}

    public var isMouseOver(default,null) = false;
    public var isVisible(default,null) = false;

    var dom : Element;
    var idleTimeoutInput : Slider;
    var brightnessInput : Slider;
    var saturateInput : Slider;
    var fadeDurationInput : Slider;
    var changeIntervalInput : Slider;
    var powerDisplay : Element;
    var powerSystem : Element;

    var powerLevel : chrome.Power.Level;

    public function new( settings : SettingsData ) {

        dom = document.getElementById( 'settings' );

        dom.onmouseover = function(_) isMouseOver = true;
        dom.onmouseout = function(_) isMouseOver = false;

        idleTimeoutInput = new Slider( 'idle-timeout', settings.idleTimeout, ' secs' );
        idleTimeoutInput.onChange = function(v) {
            onIdleTimeoutInput(v);
        }

        brightnessInput = new Slider( 'brightness', settings.brightness, '%' );
        brightnessInput.onChange = function(v) {
            onBrightnessInput(v);
        }

        saturateInput = new Slider( 'saturation', settings.saturation, '%' );
        saturateInput.onChange = function(v) {
            onSaturationInput(v);
        }

        fadeDurationInput = new Slider( 'fade-duration', settings.fadeDuration, ' ms' );
        fadeDurationInput.onChange = function(v) {
            onFadeDurationInput(v);
        }

        changeIntervalInput = new Slider( 'change-interval', settings.changeInterval, ' ms' );
        changeIntervalInput.onChange = function(v) {
            onChangeIntervalInput(v);
        }

        powerDisplay = document.getElementById( 'power-display' );
        powerDisplay.addEventListener( 'click', function(e){
            onPowerLevelChange( (powerLevel == display) ? null : display );
        }, false );

        powerSystem = document.getElementById( 'power-system' );
        powerSystem.addEventListener( 'click', function(e){
            onPowerLevelChange( (powerLevel == system) ? null : system );
        }, false );

        setPowerLevel( settings.power );
    }

    public function show() {
        dom.style.opacity = '1';
        isVisible = true;
    }

    public function hide() {
        dom.style.opacity = '0';
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
