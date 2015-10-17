package fadr.chrome;

import js.Browser.document;
import js.Browser.window;
import haxe.Timer;

class App extends fadr.App {

    override function init() {

        super.init();

        chrome.Storage.onChanged.addListener(function(changes,namespace){
            if( changes.changeInterval != null ) {
                view.changeInterval = menu.changeInterval.value = changes.changeInterval.newValue;
            }
            if( changes.fadeDuration != null ) {
                view.fadeDuration = menu.fadeDuration.value = changes.fadeDuration.newValue;
            }
            if( changes.brightness != null ) {
                view.brightness = menu.brightness.value = changes.brightness.newValue;
            }
            if( changes.saturation != null ) {
                view.saturation = menu.saturation.value = changes.saturation.newValue;
            }
            if( changes.idleTimeout != null ) {
                menu.idleTimeout.value = changes.idleTimeout.newValue;
                chrome.Idle.setDetectionInterval( changes.idleTimeout.newValue );
            }
        });
    }

    function close() {
        chrome.Runtime.getBackgroundPage(function(win:js.html.Window){
            untyped win.Fadr.stopScreensaver();
        });
    }

    override function handleDoubleClickBody(e) {
        close();
    }

    override function handleContextMenu(e) {
        super.handleContextMenu(e);
        #if !debug close(); #end
    }

    static function main() {
        window.onload = function(_){
            chrome.Storage.local.get( {
                    idleTimeout: 600,
                    //power: null,
                    brightness: 100,
                    saturation: 100,
                    fadeDuration: 1000,
                    changeInterval: 2000,
                },
                function(settings:SettingsData){
                    var app = new App( settings );
                    Timer.delay( app.init, 1 );
                }
            );
        }
    }
}
