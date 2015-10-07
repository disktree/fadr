package dream.fadr.chrome;

import chrome.Idle;
import chrome.Power;
import chrome.Storage;
import chrome.app.Runtime;
import chrome.app.Window;
import chrome.system.Display;

class Background {

    static var windows : Array<AppWindow>;

    static function startScreensaver() {
        windows = [];
        Display.getInfo(function(displayInfo){
            for( display in displayInfo ) {
                Window.create( 'screensaver.html',
                    {
                        alwaysOnTop: true,
                        visibleOnAllWorkspaces: true,
                        state: fullscreen,
                        bounds: display.bounds
                    },
                    function(win){
                        windows.push( win );
                        win.contentWindow.addEventListener( 'resize', function(e){
                            stopScreensaver();
                        });
                    }
                );
            }
        });
    }

    static function stopScreensaver() {
        if( windows != null ) {
            for( win in windows ) win.close();
            windows = null;
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
            function(data){
                Idle.setDetectionInterval( data.idleTimeout );
                Idle.onStateChanged.addListener(function(state){
                    switch state {
                    case active:
                        //stopScreensaver();
                    case locked:
                        stopScreensaver();
                    case idle:
                        startScreensaver();
                    }
                });
            }
        );

        Window.onBoundsChanged.addListener(function(){
            stopScreensaver();
        });

        Runtime.onLaunched.addListener( function(_) {
            startScreensaver();
        });

        /*
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
                    Power.releaseKeepAwake();
                }

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
                //Power.requestKeepAwake( system );
            }
        );
        */
    }
}
