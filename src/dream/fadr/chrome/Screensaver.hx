package dream.fadr.chrome;

import js.Browser.document;
import js.Browser.window;
import js.html.Element;
import haxe.Timer;
import chrome.Storage;
import chrome.Power;
import chrome.Idle;
import chrome.app.Window;
import dream.fadr.view.FadrView;

class Screensaver {

    static inline var MOUSE_HIDE_TIMEOUT = 2500;

    static var view : FadrView;
    static var menu : SettingsMenu;
    static var toggleMenuButton : Element;
    static var isMouseOverToggleButton = false;
    static var timer : Timer;

    static function close() {
        for( win in Window.getAll() )
            win.close();
    }

    static function handleMouseMove(e) {

        document.body.style.cursor = 'default';
        toggleMenuButton.style.opacity = '1';

        timer.stop();
        timer = new Timer( MOUSE_HIDE_TIMEOUT );
        timer.run = function() {
            timer.stop();
            if( !menu.isMouseOver && !isMouseOverToggleButton ) {
                document.body.style.cursor = 'none';
                menu.hide();
                toggleMenuButton.style.opacity = '0';
            }
        }
    }

    static function handleToggleMenuClick(e) {
        menu.toggle();
    }

    static function main() {

        window.onload = function(_) {

            Storage.local.get( {
                    idleTimeout: 15,
                    brightness: 100,
                    saturation: 100,
                    fadeDuration: 1000,
                    changeInterval: 1000,
                    power: null
                },
                function(data:SettingsData){

                    view = new FadrView( data );
                    view.start();

                    menu = new SettingsMenu( data );
                    menu.onIdleTimeoutInput = function(v){
                        Storage.local.set( { idleTimeout: v } );
                        Idle.setDetectionInterval( v );
                    }
                    menu.onBrightnessInput = function(v){
                        Storage.local.set( { brightness: v } );
                    }
                    menu.onSaturationInput = function(v){
                        Storage.local.set( { saturation: v } );
                    }
                    menu.onFadeDurationInput = function(v){
                        Storage.local.set( { fadeDuration: v } );
                    }
                    menu.onChangeIntervalInput = function(v){
                        Storage.local.set( { changeInterval: v } );
                    }
                    menu.onPowerLevelChange = function(level){
                        if( level == null ) {
                            Power.releaseKeepAwake();
                        } else {
                            Power.requestKeepAwake(level);
                        }
                        Storage.local.set( { power:level } );
                    }

                    Storage.onChanged.addListener(function(changes,namespace){
                        //trace(changes);
                        if( changes.idleTimeout != null ) {
                            menu.setIdleTimeout( changes.idleTimeout.newValue );
                        }
                        if( changes.brightness != null ) {
                            view.setBrightness( changes.brightness.newValue );
                            menu.setBrightness( changes.brightness.newValue );
                        }
                        if( changes.saturation != null ) {
                            view.setSaturation( changes.saturation.newValue );
                            menu.setSaturation( changes.saturation.newValue );
                        }
                        if( changes.fadeDuration != null ) {
                            view.setFadeDuration( changes.fadeDuration.newValue );
                            menu.setFadeDuration( changes.fadeDuration.newValue );
                        }
                        if( changes.changeInterval != null ) {
                            view.setChangeInterval( changes.changeInterval.newValue );
                            menu.setChangeInterval( changes.changeInterval.newValue );
                        }
                        if( changes.power != null ) {
                            menu.setPowerLevel( changes.power.newValue );
                        }
                    });

                    timer = new Timer( MOUSE_HIDE_TIMEOUT );

                    document.body.addEventListener( 'contextmenu', function(e){
                        #if !debug close(); #end
                    }, false );

                    document.body.addEventListener( 'mousemove', handleMouseMove, false );

                    view.dom.addEventListener( 'click', function(_){
                        close();
                    }, false );

                    toggleMenuButton = document.getElementById( 'settings-toggle' );
                    toggleMenuButton.addEventListener( 'click', function(e){
                        menu.toggle();
                    }, false );
                    toggleMenuButton.onmouseover = function(_) isMouseOverToggleButton = true;
                    toggleMenuButton.onmouseout = function(_) isMouseOverToggleButton = false;

                }
            );
        }
    }
}
