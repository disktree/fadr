package fadr.web;

import js.Browser.document;
import js.Browser.window;
import haxe.Timer;

class App extends fadr.App {

    var isFullscreen = false;

    override function handleDoubleClickBody(e) {
        toggleFullscreen();
    }

    override function handleContextMenu(e) {
        super.handleContextMenu(e);
        toggleGUI();
        /*
        if( menu.toggle() )
            footer.style.opacity = '1';
        else
            footer.style.opacity = '0';
            */
    }


    function toggleFullscreen() {
        if( isFullscreen ) {
            untyped document.webkitExitFullscreen();
            isFullscreen = false;
        } else {
            untyped document.body.webkitRequestFullscreen();
            isFullscreen = true;
        }
    }

    static function main() {

        window.onload = function(_){

            var app = new App( Storage.get() );
            Timer.delay( app.init, 1 );

            /*
            untyped __js__( "navigator.serviceWorker.register( 'serviceworker.js' ).then(function(registration){
                console.log(registration);
            }).catch(function(err){
                console.log(err);
            });");
            */
        }
    }
}
