package fadr.chrome;

import chrome.Idle;
import chrome.Power;
import chrome.Storage;
import chrome.app.Runtime;
import chrome.app.Window;
import chrome.system.Display;

@:keep
@:expose
class Background {

    static var active = false;

    static function startScreensaver() {
        if( active )
            return;
        active = true;
        Display.getInfo(function(displayInfo){
            for( display in displayInfo ) {
                Window.create( 'app.html',
                    {
                        alwaysOnTop: true,
                        visibleOnAllWorkspaces: true,
                        state: fullscreen,
                        bounds: display.bounds,
                    },
                    function(win:AppWindow){
                        win.contentWindow.addEventListener( 'resize', function(e){
                            stopScreensaver();
                        });
                    }
                );
            }
        });
    }

    static function stopScreensaver() {
        if( active ) {
            for( win in Window.getAll() )
                win.close();
            active = false;
        }
    }

    static function main() {

        untyped js.Browser.window.Fadr = Background;

        Runtime.onLaunched.addListener( function(?e) {
            startScreensaver();
        });


        Storage.local.get( {
                fadeDuration: 1000,
                changeInterval: 1000,
                brightness: 100,
                saturation: 100,
                //screensaver: false, //TODO
                //idleTimeout: 600,
                powerLevel: null,
            },
            function(settings:SettingsData){

                /*
                Idle.setDetectionInterval( settings.idleTimeout );
                Idle.onStateChanged.addListener(function(state){
                    switch state {
                    case active: //TODO ?
                    case locked: stopScreensaver();
                    case idle: startScreensaver();
                    }
                });
                * /

                /*
                if( data.power == null ) {
                    Power.releaseKeepAwake();
                } else {
                    Power.requestKeepAwake( data.power );
                }
                */

                /*
                Window.onBoundsChanged.addListener(function(){
                    //stopScreensaver();
                });
                */
            }
        );
    }
}
