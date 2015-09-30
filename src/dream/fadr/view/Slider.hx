package dream.fadr.view;

import js.Browser.document;
import js.html.DivElement;
import js.html.InputElement;

class Slider {

    public dynamic function onChange( value : Int ) {}

    var postText : String;
    var input : InputElement;
    var label : DivElement;
    var step : Int;

    public function new( id : String, value : Int, ?postText : String, ?step : Int ) {

        this.postText = postText;

        input = cast document.getElementById( id );

        this.step = (step == null) ? Std.parseInt( input.step ) : step;

        label = cast document.getElementById( '$id-label' );

        setValue( value );

        input.addEventListener( 'input', handleInput, false );
        input.addEventListener( 'change', handleInputChange, false );
        input.addEventListener( 'mousewheel', handleMouseWheel, false );
    }

    public function setValue( value : Int ) {
        input.value = '$value';
        updateLabelValue();
    }

    function updateLabelValue() {
        var str = input.value;
        if( postText != null ) str += '$postText';
        label.textContent = str;
    }

    function getValue() : Int {
        return Std.parseInt( input.value );
    }

    function handleInput(e) {
        updateLabelValue();
    }

    function handleInputChange(e) {
        updateLabelValue();
        var str = untyped e.target.value;
        onChange( Std.parseInt( str ) );
    }

    function handleMouseWheel(e) {
        var v = if( e.wheelDelta > 0 ) {
            getValue() + step * 5;
        } else {
            getValue() - step * 5;
        }
        setValue( v );
        onChange( v );
    }
}
