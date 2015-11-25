package fadr;

import js.Browser.document;
import js.html.Element;
import haxe.Timer;

class App {

    static inline var MOUSE_HIDE_TIMEOUT = 2500;

    var menu : fadr.SettingsMenu;
    var view : fadr.View;

    var menuToggle : Element;
    var timer : Timer;

    #if !mobile
    var footer : Element;
    #end

    function new( settings : SettingsData ) {

        view = new fadr.View( fadr.macro.BuildColorPalettes.fromSources( 100000, 15728640 ), settings );
        menu = new SettingsMenu( view, settings );

        menuToggle = document.getElementById( 'settings-toggle' );

        #if !mobile
        footer = document.getElementsByTagName( 'footer' )[0];
        #end
    }

    function init() {

        view.start();

        #if !mobile
        menuToggle.addEventListener( 'click', handleSettingsToggleClick, false );
        document.body.addEventListener( 'dblclick', handleDoubleClickBody, false );
        document.body.addEventListener( 'contextmenu', handleContextMenu, false );
        document.body.addEventListener( 'mousemove', handleMouseMove, false );
        timer = new Timer( MOUSE_HIDE_TIMEOUT );
        document.getElementById( 'title' ).onclick = function(_){
            toggleGUI();
        };
        #end
    }

    function toggleGUI() {
        #if mobile
        menu.toggle();
        #else
        if( menu.toggle() )
            footer.style.opacity = '1';
        else
            footer.style.opacity = '0';
        #end
    }

    function handleSettingsToggleClick(e) {

        e.preventDefault();
        toggleGUI();

        /*
        if( menu.isVisible ) {
            trace("HIDE");
            menu.hide();
        } else {
            trace("SHOOW");
            menu.show();
        }
        */

        /*
        e.preventDefault();

        trace(menu.isVisible );

        if( menu.toggle() )
            footer.style.opacity = '1';
        else
            footer.style.opacity = '0';
            */
    }

    #if !mobile

    function handleDoubleClickBody(e) {}

    function handleContextMenu(e) {
        #if !debug e.preventDefault(); #end
    }

    function handleMouseMove(e) {

        document.body.style.cursor = 'default';
        menuToggle.style.opacity = '1';
        footer.style.opacity = '1';

        timer.stop();
        timer = new Timer( MOUSE_HIDE_TIMEOUT );
        timer.run = handleTimeout;
    }

    function handleTimeout() {
        timer.stop();
        if( !menu.isVisible ) {
            document.body.style.cursor = 'none';
            menuToggle.style.opacity = '0';
            footer.style.opacity = '0';
        }
    }

    #end
}
