package fadr.android;

import js.Browser.document;
import js.Browser.window;
import fadr.view.FadrView;

class Dream {

    static function main() {

        window.onload = function(_) {

            var settings = Storage.get();
            var palettes = fadr.macro.BuildColorPalettes.fromSources(100000);
            var view = new FadrView( palettes, settings );
            view.start();
        }
    }
}
