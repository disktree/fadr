package fadr.android;

import js.Browser.window;

class Dream {

    static function main() {
        window.onload = function(_) {
            var view = new fadr.View( fadr.macro.BuildColorPalettes.fromSources( 100000 ), Storage.get() );
            view.start();
        }
    }
}
