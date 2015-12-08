package fadr.android;

import js.Browser.document;
import js.Browser.window;
import haxe.Timer;

@:keep
class Settings extends fadr.App {

    static var instance : Settings;

    @:keep
    public static function showSettingsMenu() {
        instance.menu.show();
    }

    static function main() {

        window.onload = function(_) {

            instance = new Settings( Storage.get() );
            instance.init();

            if( document.body.id == 'settings-activity' ) {
                instance.menuToggle.style.opacity = '1';
                instance.menu.show();
            }
        }
    }
}
