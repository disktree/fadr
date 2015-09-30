package dream.fadr.chrome;

import chrome.Idle;
import chrome.Power;
import chrome.Storage;
import chrome.Windows;

class Background {

    static var win : Window;

    static function startScreensaver() {
        if( win == null ) {
            Windows.create( {
                url: "screensaver.html",
                state: fullscreen,
                focused: true
            }, function(?win){
                Background.win = win;
            });
        }
    }

    static function stopScreensaver() {
        if( win != null ) {
            Windows.remove( win.id, function(){
                win = null;
            });
        }
    }

    static function main() {

        Storage.local.get( null,

            function(settings){

                Idle.setDetectionInterval( settings.idleTimeout );

                Storage.onChanged.addListener(function(changes,namespace){
                    if( changes.idleTimeout != null ) {
                        Idle.setDetectionInterval( changes.idleTimeout.newValue );
                    }
                });

                Idle.onStateChanged.addListener(function(state){
                    switch state {
                    case active:
                        stopScreensaver();
                    case idle:
                        startScreensaver();
                    case locked:
                        //TODO ? show
                    }
                });

                //Power.requestKeepAwake( display );
                Power.requestKeepAwake( system );
            }
        );
    }
}
