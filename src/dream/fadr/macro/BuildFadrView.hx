package dream.fadr.macro;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;
import sys.io.File;

using Lambda;
using haxe.io.Path;

class BuildFadrView {

    public static function build() : Array<Field> {

		var fields = Context.getBuildFields();

        var COLORS = new Array<ColorPalette>();
        var colorExpr = ~/([0-9a-f]{6})/i;
        var path = 'res/color';
        for( f in FileSystem.readDirectory( path ) ) {
            var palette = { name : f.withoutExtension(), colors : new Array<String>() };
            var colors = File.getContent( '$path/$f' ).split( '\n' );
            for( color in colors ) {
                if( color.length == 0 )
                    continue;
                if( !colorExpr.match( color ) ) {
                    Context.warning( 'Invalid color value: '+color+' [$f]', Context.currentPos() );
                    continue;
                }
                if( !palette.colors.has( color ) )
                    palette.colors.push( color );
            }
            COLORS.push( palette );
        }

        fields.push({
            name: 'COLORS',
            access: [APublic,AStatic],
            kind: FVar(macro : Array<ColorPalette>, macro $v{COLORS} ),
            pos: Context.currentPos()
        });

        return fields;
    }
}
