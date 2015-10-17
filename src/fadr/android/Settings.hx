package fadr.android;

import js.Browser.document;
import js.Browser.window;
import haxe.Timer;

class Settings extends fadr.App {

    static function main() {
        window.onload = function(_) {
            var app = new App( Storage.get() );
            Timer.delay( app.init, 1 );
        }
    }
}
