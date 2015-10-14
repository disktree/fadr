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

        // Store into window object to provide access from app
        untyped js.Browser.window.Fadr = Background;

        Runtime.onLaunched.addListener( function(?e) {
            startScreensaver();
        });

        Idle.onStateChanged.addListener(function(state){
            switch state {
            case active:
            case locked:
                stopScreensaver();
            case idle:
                startScreensaver();
            }
        });

        Storage.local.get( {
                idleTimeout: 300,
                power: null,
                fadeDuration: 1000,
                changeInterval: 1000,
                brightness: 100,
                saturation: 100,
            },
            function(data:SettingsData){

                Idle.setDetectionInterval( data.idleTimeout );

                if( data.power == null ) {
                    Power.releaseKeepAwake();
                } else {
                    Power.requestKeepAwake( data.power );
                }

                /*
                Window.onBoundsChanged.addListener(function(){
                    //stopScreensaver();
                });
                */
            }
        );
    }
}
