package dream.fadr.chrome;

import js.Browser.document;
import js.html.Element;
import js.html.SelectElement;
import dream.fadr.view.Slider;

class SettingsView {

    public dynamic function onChange( type : String, value : Int ) {}

    var dom : Element;

    public function new( settings : SettingsData ) {

        dom = document.getElementById( 'options' );

        var idleTimeoutInput = new Slider( 'idle-timeout', settings.idleTimeout, ' secs' );
        idleTimeoutInput.onChange = function(v) {
            onChange( 'idleTimeout', v );
        }

        /*
        var selectPowerInput : SelectElement = cast document.getElementById( 'power' );
        selectPowerInput.onchange = function(e) {
            trace(e.target.value);
        }
        */

        var brightnessInput = new Slider( 'brightness', settings.brightness, '%' );
        brightnessInput.onChange = function(v) {
            onChange( 'brightness', v );
        }

        var saturateInput = new Slider( 'saturation', settings.saturation, '%' );
        saturateInput.onChange = function(v) {
            onChange( 'saturation', v );
        }

        var fadeDurationInput = new Slider( 'fade-duration', settings.fadeDuration, ' ms' );
        fadeDurationInput.onChange = function(v) {
            onChange( 'fadeDuration', v);
        }

        var changeIntervalInput = new Slider( 'change-interval', settings.changeInterval, ' ms' );
        changeIntervalInput.onChange = function(v) {
            onChange( 'changeInterval', v );
        }
    }
}
