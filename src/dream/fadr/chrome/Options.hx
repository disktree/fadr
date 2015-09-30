package dream.fadr.chrome;

import js.Browser.document;
import js.Browser.window;
import chrome.Storage;
import dream.fadr.view.FadrView;

class Options {

    static var options : OptionsView;
    static var view : FadrView;

    static function main() {

        window.onload = function(_) {

            document.body.addEventListener( 'contextmenu', function(e){
                e.preventDefault();
            }, false );

            Storage.local.get( {
                    idleTimeout: 15,
                    brightness: 100,
                    saturation: 100,
                    fadeDuration: 1000,
                    changeInterval: 1000
                },
                function(settings){

                    view = new FadrView( settings.brightness, settings.saturation, settings.fadeDuration, settings.changeInterval );
                    view.start();

                    options = new OptionsView( settings );
                    options.onChange = function(type,value) {

                        switch type {
                        case 'brightness': view.setBrightness( value );
                        case 'saturation': view.setSaturation( value );
                        case 'fadeDuration': view.setFadeDuration( value );
                        case 'changeInterval': view.setChangeInterval( value );
                        }

                        var data = {};
                        Reflect.setField( data, type, value );
                        Storage.local.set( data );
                    }
                }
            );
        }
    }
}
