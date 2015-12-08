package fadr.android;

import js.Browser.window;

@:keep
class Main extends fadr.App {

    static function main() {
        window.onload = function(_) {
            var app = new Settings( Storage.get() );
            app.init();
        }
    }
}
