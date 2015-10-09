package dream.fadr.chrome;

import chrome.Idle;
import chrome.Power;
import chrome.Storage;
import chrome.app.Runtime;
import chrome.app.Window;
import chrome.system.Display;

class Background {

    static function startScreensaver() {
        Display.getInfo(function(displayInfo){
            for( display in displayInfo ) {
                Window.create( 'screensaver.html',
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
        for( win in Window.getAll() ) win.close();
    }

    static function main() {

        Runtime.onLaunched.addListener( function(?e) {

            Storage.local.get( {
                    idleTimeout: 300,
                    power: null,
                    fadeDuration: 1000,
                    changeInterval: 1000,
                    brightness: 100,
                    saturation: 100,
                },
                function(data:SettingsData){

                    if( data.power == null ) {
                        Power.releaseKeepAwake();
                    } else {
                        Power.requestKeepAwake( data.power );
                    }

                    Idle.setDetectionInterval( data.idleTimeout );
                    Idle.onStateChanged.addListener(function(state){
                        switch state {
                        case active,locked:
                            stopScreensaver();
                        case idle:
                            startScreensaver();
                        }
                    });

                    Window.onBoundsChanged.addListener(function(){
                        stopScreensaver();
                    });

                    startScreensaver();
                }
            );
        });
    }
}
