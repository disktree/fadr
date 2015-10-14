package fadr.android;

import js.Browser.document;
import js.Browser.window;
import fadr.view.FadrView;

class Settings {

    static var view : FadrView;
    static var menu : SettingsMenu;

    static function main() {

        window.onload = function(_) {

            var settings = Storage.get();

            var palettes = fadr.macro.BuildColorPalettes.fromSources(100000);
            var view = new FadrView( palettes, settings );
            view.start();

            menu = new SettingsMenu( settings );
            menu.onFadeDurationChange = function(v){
                view.setFadeDuration(v);
            }
            menu.onChangeIntervalChange = function(v){
                view.setChangeInterval(v);
            }
            menu.onBrightnessInput = function(v){
                view.setBrightness( v );
            }
            menu.onBrightnessChange = function(v){
                //Storage.local.set( { brightness: v } );
            }
            menu.onSaturationInput = function(v){
                view.setSaturation(v);
            }
            menu.onSaturationChange = function(v){
                //Storage.local.set( { saturation: v } );
            }
        }
    }
}
