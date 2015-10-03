package dream.fadr.chrome;

import chrome.Idle;
import chrome.Power;
import chrome.Runtime;
import chrome.Storage;
import chrome.Windows;

class Background {

    static var window : Window;

    static function startScreensaver() {
        if( window == null ) {
            Windows.create( {
                url: "screensaver.html",
                state: fullscreen,
                focused: true
            }, function(?win){
                window = win;
            });
        }
    }

    static function stopScreensaver() {
        if( window != null ) {
            Windows.remove( window.id, function(){
                window = null;
            });
        }
    }

    static function main() {

        Storage.local.get( {
                idleTimeout: 15,
                power: chrome.Power.Level.display,
                brightness: 100,
                saturation: 100,
                fadeDuration: 1000,
                changeInterval: 1000
            },

            function(settings){

                //trace(settings);

                if( settings.power != null ) {
                    Power.requestKeepAwake( settings.power );
                } else {
                    //Power.releaseKeepAwake();
                }

                Idle.onStateChanged.addListener(function(state){
                    trace(state);
                    switch state {
                    case active,locked: stopScreensaver();
                    case idle: startScreensaver();
                    }
                });
                Idle.setDetectionInterval( settings.idleTimeout );

                Storage.onChanged.addListener(function(changes,namespace){
                    if( changes.idleTimeout != null ) {
                        Idle.setDetectionInterval( changes.idleTimeout.newValue );
                    }
                });
            }
        );

        Runtime.onSuspend.addListener(function(){
            trace("Runtime.suspend");
        });
    }
}
