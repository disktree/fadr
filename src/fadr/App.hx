package fadr;

import js.Browser.document;
import js.html.Element;
import haxe.Timer;

class App {

    static inline var MOUSE_HIDE_TIMEOUT = 2500;

    var menu : fadr.SettingsMenu;
    var view : fadr.View;

    #if !mobile
    var title : Element;
    var footer : Element;
    var timer : Timer;
    #end

    function new( settings : SettingsData ) {

        view = new fadr.View( fadr.macro.BuildColorPalettes.fromSources( 100000 ), settings );
        menu = new SettingsMenu( view, settings );

        #if !mobile
        title = document.getElementsByTagName( 'header' )[0];
        footer = document.getElementsByTagName( 'footer' )[0];
        hideGUI();
        #end
    }

    function init() {

        view.start();

        #if !mobile
        document.body.addEventListener( 'dblclick', handleDoubleClickBody, false );
        document.body.addEventListener( 'contextmenu', handleContextMenu, false );
        document.body.addEventListener( 'mousemove', handleMouseMove, false );
        timer = new Timer( MOUSE_HIDE_TIMEOUT );
        timer.run = handleTimeout;
        #end
    }

    #if !mobile

    function hideGUI() {
        title.style.opacity = footer.style.opacity = '0';
        menu.hide();
        document.body.style.cursor = 'none';
        //toggleMenuButton.style.opacity = '0';
    }

    function handleDoubleClickBody(e) {}

    function handleContextMenu(e) {
        #if !debug e.preventDefault(); #end
    }

    function handleMouseMove(e) {

        title.style.opacity = footer.style.opacity = '1';
        menu.show();
        document.body.style.cursor = 'default';

        timer.stop();
        timer = new Timer( MOUSE_HIDE_TIMEOUT );
        timer.run = handleTimeout;
    }

    function handleTimeout() {
        timer.stop();
        if( !menu.isMouseOver ) { //&& !isMouseOverToggleButton ) {
            hideGUI();
        }

    }

    #end
}
