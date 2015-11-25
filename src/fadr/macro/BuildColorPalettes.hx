package fadr.macro;

#if macro
import haxe.macro.Context;
import sys.FileSystem;
import sys.io.File;
using Lambda;
using haxe.io.Path;
#end

class BuildColorPalettes {

    macro public static function fromSources( clampBelow : Int = 0, clampAbove : Int = 16777215 ) : ExprOf<Array<ColorPalette>> {

        //trace(0xffffff);
        //16777216
        //12582912

        var COLORS = new Array<ColorPalette>();
        var colorExpr = ~/([0-9a-f]{6})/i;
        var path = 'res/color';
        for( f in FileSystem.readDirectory( path ) ) {
            var palette = { name : f.withoutExtension(), colors : new Array<String>() };
            var colors = File.getContent( '$path/$f' ).split( '\n' );
            for( color in colors ) {
                if( color.length == 0 )
                    continue;
                color = color.toLowerCase();
                if( color == '#ffffff' )
                    continue;
                if( !colorExpr.match( color ) ) {
                    Context.warning( 'Invalid color value: '+color+' [$f]', Context.currentPos() );
                    continue;
                }
                var colorInt = Std.parseInt( '0x'+color.substr(1) );
                if( colorInt < clampBelow ) {
                    continue;
                } else if( colorInt > clampAbove ) {
                    continue;
                }
                if( !palette.colors.has( color ) )
                    palette.colors.push( color );
            }
            COLORS.push( palette );
        }

        return macro $v{COLORS};
    }
}
