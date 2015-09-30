package dream.fadr.android;

import js.Browser.document;
import js.Browser.window;
import dream.fadr.view.FadrView;

class Settings {

    static var view : FadrView;

    static function main() {

        window.onload = function(_) {

            var data = Storage.get();

            var view = new FadrView( data );
            view.start();

            var settings = new SettingsView( data );
            settings.onChange = function(type,value) {

                //trace(type+":"+value);

                Reflect.setField( data, type, value );
                Storage.set( data );

                switch type {
                case 'brightness': view.setBrightness( value );
                case 'saturation': view.setSaturation( value );
                case 'fadeDuration': view.setFadeDuration( value );
                case 'changeInterval': view.setChangeInterval( value );
                }
            }
        }
    }
}
