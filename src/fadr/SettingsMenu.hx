package fadr;

import js.Browser.document;
import js.html.Element;
import fadr.gui.Slider;
import fadr.gui.Select;

class SettingsMenu {

    public var fadeDuration(default,null) : Slider;
    public var changeInterval(default,null) : Slider;
    public var brightness(default,null) : Slider;
    public var saturation(default,null) : Slider;

    /*
    #if chrome
    public var idleTimeout(default,null) : Slider;
    public var powerLevel(default,null) : Select;
    #end
    */

    //public var isMouseOver(default,null) = false;
    public var isVisible(default,null) = false;

    var element : Element;
    var view : fadr.View;

    public function new( view : fadr.View, settings : SettingsData ) {

        this.view = view;

        element = document.getElementById( 'settings' );


        ///// Section Fade

        var section = document.getElementById( 'settings-fade' );
        fadeDuration = new Slider( 'fade-duration', settings.fadeDuration, 0, 10000, 100, ' ms' );
        fadeDuration.onChange = function(v) {
            view.fadeDuration = v;
            saveSettings( 'fadeDuration', v );
        }
        section.appendChild( fadeDuration.element );
        changeInterval = new Slider( 'change-interval', settings.changeInterval, 0, 10000, 100, ' ms' );
        changeInterval.onChange = function(v) {
            view.changeInterval = v;
            saveSettings( 'changeInterval', v );
        }
        section.appendChild( changeInterval.element );


        ///// Section Filter

        var section = document.getElementById( 'settings-filter' );
        brightness = new Slider( 'brightness', settings.brightness, 1, 200, 1, '%' );
        brightness.onInput = function(v){
            view.brightness = v;
        }
        brightness.onChange = function(v) saveSettings( 'brightness', v );
        section.appendChild( brightness.element );
        saturation = new Slider( 'saturation', settings.saturation, 0, 200, 1, '%' );
        saturation.onInput = function(v){
            view.saturation = v;
        }
        saturation.onChange = function(v) saveSettings( 'saturation', v );
        section.appendChild( saturation.element );

        /*
        #if chrome ///// Section Screensaver

        var section = document.getElementById( 'settings-screensaver' );

        //var screensaver = new Select( 'screensaver', ['on','off'], false );
        //section.appendChild( screensaver.element );


        idleTimeout = new Slider( 'idle-timeout', settings.idleTimeout, 15, 3600, 5, ' secs' );
        idleTimeout.onChange = function(v) saveSettings( 'idleTimeout', v );
        section.appendChild( idleTimeout.element );

        powerLevel = new Select( 'keep', ['display','system'], 'awake', false );
        if( settings.powerLevel != null ) powerLevel.select( settings.powerLevel );
        powerLevel.onChange = function(id,selected){
            chrome.Storage.local.set( { powerLevel: selected ? id : null } );
        }
        section.appendChild( powerLevel.element );

        #end
        */

        /*
        #if !mobile
        element.onmouseover = function(_) isMouseOver = true;
        element.onmouseout = function(_) isMouseOver = false;
        #end
        */
    }

    public function show() {
        element.style.opacity = '1';
        isVisible = true;
    }

    public function hide() {
        element.style.opacity = '0';
        isVisible = false;
    }

    public function toggle() : Bool {
        isVisible ? hide() : show();
        return isVisible;
    }

    #if chrome

    function saveSettings<T>( field : String, value : T ) {
        var obj : SettingsData = cast {};
        Reflect.setField( obj, field, value );
        chrome.Storage.local.set( obj );
    }

    #else

    function saveSettings<T>( field : String, value : T ) {
        fadr.web.Storage.set( {
            fadeDuration: view.fadeDuration,
            changeInterval: view.changeInterval,
            brightness: view.brightness,
            saturation: view.saturation,
        });
    }

    #end

}
