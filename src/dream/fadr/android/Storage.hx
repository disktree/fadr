package dream.fadr.android;

import js.Browser;
import haxe.Json;

class Storage {

    static inline var ID = 'fadr';

    static var storage = Browser.getLocalStorage();

    public static function get() : SettingsData {
        var _data = storage.getItem( ID );
        if( _data == null ) {
            var defaultSettings = {
                brightness: 100,
                saturation: 100,
                fadeDuration: 1000,
                changeInterval: 1000
            };
            set( defaultSettings );
            return defaultSettings;
        } else {
            return Json.parse( _data );
        }
    }

    public static function set( data : SettingsData ) {
        storage.setItem( ID, Json.stringify( data ) );
    }
}
