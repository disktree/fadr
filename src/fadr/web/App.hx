package fadr.web;

import js.Browser.document;
import js.Browser.window;
import haxe.Timer;

class App extends fadr.App {

    var isFullscreen = false;

    function toggleFullscreen() {
        if( isFullscreen ) {
            untyped document.webkitExitFullscreen();
            isFullscreen = false;
        } else {
            untyped document.body.webkitRequestFullscreen();
            isFullscreen = true;
        }
    }

    override function handleDoubleClickBody(e) {
        toggleFullscreen();
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
