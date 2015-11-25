package fadr.macro;

import haxe.macro.Context;
import om.io.FileSync.*;

class Build {

    static var debug : Bool;
    static var platform : String;
    static var dst : String;

    static function app() {

        debug = Context.definedValue( "debug" ) == "1";
        platform = Context.definedValue( 'platform' );
        dst = 'build/$platform';

        syncDirectory( 'res/font', '$dst/font' );
        syncDirectory( 'res/image', '$dst/image' );

        switch platform {
        case 'android':
            lessc( 'dream' );
            lessc( 'settings' );
            syncFile( 'res/android/dream.html', '$dst/dream.html' );
            syncFile( 'res/android/settings.html', '$dst/settings.html' );
            syncDirectory( dst, 'data/fadr-android/assets' );
        case 'chrome':
            lessc( 'app' );
            syncFile( 'res/icon/fadr-desktop-16.png', '$dst/icon/fadr-desktop-16.png' );
            syncFile( 'res/icon/fadr-desktop-48.png', '$dst/icon/fadr-desktop-48.png' );
            syncFile( 'res/icon/fadr-desktop-128.png', '$dst/icon/fadr-desktop-128.png' );
            syncFile( 'res/chrome/manifest.json', '$dst/manifest.json' );
            syncFile( 'res/chrome/app.html', '$dst/app.html' );
        case 'web':
            lessc( 'app', 'fadr' );
            syncFile( 'res/icon/fadr-desktop-16.png', '$dst/icon/fadr-desktop-16.png' );
            syncFile( 'res/icon/fadr-desktop-48.png', '$dst/icon/fadr-desktop-48.png' );
            syncFile( 'res/icon/fadr-desktop-128.png', '$dst/icon/fadr-desktop-128.png' );
            syncFile( 'res/web/manifest.json', '$dst/manifest.json' );
            syncFile( 'res/web/index.html', '$dst/index.html' );
            //syncFile( 'res/web/serviceworker.js', '$dst/serviceworker.js' );
        }
    }

    static function lessc( srcName : String, ?dstName : String ) {
        if( dstName == null ) dstName = srcName;
        var srcPath = 'res/$platform/$srcName.less';
        var dstPath = '$dst/$dstName.css';
        //if( needsUpdate( srcPath, dstPath ) ) {
            var args = [ srcPath, dstPath, '--no-color' ];
            if( !debug ) {
                args.push( '-x' );
                args.push( '--clean-css' );
            }
            var lessc = new sys.io.Process( 'lessc', args );
            var e = lessc.stderr.readAll().toString();
            if( e.length > 0 )
                Context.error( e.toString(), Context.currentPos() );
        //}
    }
}
