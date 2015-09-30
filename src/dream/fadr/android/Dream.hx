package dream.fadr.android;

import js.Browser.document;
import js.Browser.window;
import dream.fadr.view.FadrView;

class Dream {

    static function main() {

        window.onload = function(_) {

            var data = Storage.get();

            var view = new FadrView( data );
            view.start();
        }
    }
}
