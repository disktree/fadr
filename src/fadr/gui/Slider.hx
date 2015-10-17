package fadr.gui;

import js.Browser.document;
import js.html.DivElement;
import js.html.InputElement;

class Slider {

    public dynamic function onInput( v : Int ) {}
    public dynamic function onChange( v : Int ) {}

    public var element(default,null) : DivElement;
    public var value(get,set) : Int;

    var postText : String;
    var min : Int;
    var max : Int;
    var step : Int;
    var label : DivElement;
    var input : InputElement;

    public function new( id : String, value : Int, min : Int, max : Int, step : Int, ?postText : String ) {

        this.postText = postText;
        this.min = min;
        this.max = max;
        this.step = step;

        element = document.createDivElement();
        element.classList.add( 'slider' );

        var title = document.createDivElement();
        title.classList.add( 'title' );
        title.textContent = id;
        element.appendChild( title );

        label = document.createDivElement();
        label.classList.add( 'label' );
        element.appendChild( label );

        input = document.createInputElement();
        input.type = 'range';
        input.id = id;
        input.min = '$min';
        input.max = '$max';
        input.step = '$step';
        element.appendChild( input );

        set_value( value );

        input.addEventListener( 'input', handleInput, false );
        input.addEventListener( 'change', handleInputChange, false );

        #if !mobile
        input.addEventListener( 'mousewheel', handleMouseWheel, false );
        #end
    }

    inline function get_value() : Int {
        return Std.parseInt( input.value );
    }

    function set_value( v : Int ) : Int {
        if( v < min ) v = min else if( v > max ) v = max;
        input.value = '$v';
        updateLabelText();
        return v;
    }

    function updateLabelText() {
        var str = input.value;
        if( postText != null ) str += '$postText';
        label.textContent = str;
    }

    function handleInput(e) {
        updateLabelText();
        onInput( value );
    }

    function handleInputChange(e) {
        updateLabelText();
        onChange( value );
    }

    #if !mobile

    function handleMouseWheel(e) {
        var v = if( e.wheelDelta > 0 ) {
            value + step * 5;
        } else {
            value - step * 5;
        }
        value = v;
        onInput( value );
        onChange( value );
    }

    #end
}
