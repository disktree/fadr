package dream.fadr.chrome;

import om.io.FileSync.*;

class Build {

    static function app() {

        syncDirectory( 'res/chrome/icon', 'build/chrome/icon' );
        syncDirectory( 'res/font', 'build/chrome/font' );
        //syncDirectory( 'res/image', 'build/chrome/image' );

        syncFile( 'res/chrome/manifest.json', 'build/chrome/manifest.json' );
        syncFile( 'res/chrome/screensaver.html', 'build/chrome/screensaver.html' );
        syncFile( 'res/chrome/options.html', 'build/chrome/options.html' );
        //syncFile( 'res/chrome/screensaver.css', 'build/chrome/screensaver.css' );
    }
}
