package fadr;

import js.Browser.document;
import js.html.Element;
import haxe.Timer;

class App {

    static inline var HIDE_TIMEOUT = 2500;

    var menuToggle : Element;
    var menu : fadr.SettingsMenu;
    var view : fadr.View;

    var timer : Timer;

    #if !mobile
    var footer : Element;
    #end

    function new( settings : SettingsData ) {

        timer = new Timer( HIDE_TIMEOUT );

        view = new fadr.View( fadr.macro.BuildColorPalettes.fromSources( 100000, 15728640 ), settings );
        menu = new fadr.SettingsMenu( view, settings );
        menuToggle = document.getElementById( 'settings-toggle' );

        #if !mobile
        footer = document.getElementsByTagName( 'footer' )[0];
        #end
    }

    function init() {

        view.start();

        #if mobile
        document.body.addEventListener( 'touchstart', handleTouchStart, false );

        #else
        document.body.addEventListener( 'dblclick', handleDoubleClickBody, false );
        document.body.addEventListener( 'contextmenu', handleContextMenu, false );
        document.body.addEventListener( 'mousemove', handleMouseMove, false );
        document.getElementById( 'title' ).onclick = function(_) toggleGUI();
        menuToggle.addEventListener( 'click', handleSettingsToggleClick, false );

        #end
    }

    function startTimer() {
        timer.stop();
        timer = new Timer( HIDE_TIMEOUT );
        timer.run = handleTimeout;
    }

    #if mobile

    function handleTouchStart(e){
        switch e.target.id {
        case 'fadr':
            if( menu.isVisible ) {
                menu.hide();
                startTimer();
            } else {
                if( menuToggle.style.opacity == '1' ) {
                    menuToggle.style.opacity = '0';
                    //untyped AndroidApp.finish();
                } else {
                    menuToggle.style.opacity = '1';
                    startTimer();
                }
            }
        case 'settings-toggle':
            menu.toggle();
        }
    }

    function handleTimeout() {
        timer.stop();
        if( !menu.isVisible ) menuToggle.style.opacity = '0';
    }

    #else

    function toggleGUI() {
        footer.style.opacity = menu.toggle() ? '1' : '0';
    }

    function handleSettingsToggleClick(e) {
        e.preventDefault();
        toggleGUI();
    }

    function handleDoubleClickBody(e) {}

    function handleContextMenu(e) {
        #if !debug e.preventDefault(); #end
    }

    function handleMouseMove(e) {

        document.body.style.cursor = 'default';
        menuToggle.style.opacity = footer.style.opacity = '1';

        startTimer();
    }

    function handleTimeout() {
        timer.stop();
        if( !menu.isVisible ) {
            document.body.style.cursor = 'none';
            menuToggle.style.opacity = footer.style.opacity = '0';
        }
    }

    #end
}
