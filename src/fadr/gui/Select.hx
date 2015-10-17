package fadr.gui;

import js.Browser.document;
import js.html.DivElement;
import js.html.SpanElement;
import haxe.ds.StringMap;

class Select {

    static inline var CLASS_SELECTED = 'selected';

    public dynamic function onChange( id : String, selected : Bool ) {}

    public var element(default,null) : DivElement;
    public var allowMultiSelect(default,null) : Bool;

    var options : StringMap<SpanElement>;

    public function new( preText : String, options : Array<String>, ?postText : String, allowMultiSelect = false ) {

        this.allowMultiSelect = allowMultiSelect;

        element = document.createDivElement();
        element.classList.add( 'select' );

        var pre = document.createSpanElement();
        pre.textContent = preText;
        element.appendChild( pre );

        this.options = new StringMap();

        for( id in options ) {
            var e = document.createSpanElement();
            e.classList.add( 'option' );
            e.id = id;
            e.textContent = id;
            e.addEventListener( 'click', handleClickOption, false );
            element.appendChild( e );
            this.options.set( id, e );
        }

        if( postText != null ) {
            var post = document.createSpanElement();
            post.textContent = postText;
            element.appendChild( post );
        }
    }

    public function select( id : String ) {
        options.get( id ).classList.add( CLASS_SELECTED );
        if( !allowMultiSelect )
            unselectOthers( id );
    }

    public function unselect( id : String ) {
        options.get( id ).classList.remove( CLASS_SELECTED );
    }

    function unselectOthers( id : String ) {
        for( key in options.keys() ) {
            if( key != id ) {
                var other = options.get( key );
                if( other.classList.contains( CLASS_SELECTED ) ) {
                    other.classList.remove( CLASS_SELECTED );
                }
            }
        }
    }

    function handleClickOption(e) {
        var option = options.get( e.target.id );
        if( option.classList.contains( CLASS_SELECTED ) ) {
            option.classList.remove( CLASS_SELECTED );
            onChange( e.target.id, false );
        } else {
            option.classList.add( CLASS_SELECTED );
            if( !allowMultiSelect )
                unselectOthers( e.target.id );
            onChange( e.target.id, true );
        }
    }
}
