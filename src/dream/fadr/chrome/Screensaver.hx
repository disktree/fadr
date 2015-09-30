package dream.fadr.chrome;

import js.Browser.document;
import js.Browser.window;
import chrome.Storage;
import dream.fadr.view.FadrView;

class Screensaver {

    static var view : FadrView;

    static function main() {

        window.onload = function(_) {

            Storage.local.get( {
                    idleTimeout: 15,
                    brightness: 100,
                    saturation: 100,
                    fadeDuration: 1000,
                    changeInterval: 1000
                },
                function(data){
                    view = new FadrView( data.brightness, data.saturation, data.fadeDuration, data.changeInterval );
                    view.start();
                }
            );
        }
    }
}
