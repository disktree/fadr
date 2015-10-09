package dream.fadr.chrome;

import om.io.FileSync.*;

class Build {

    static function app() {

        var dst = 'build/chrome';

        syncDirectory( 'res/chrome/icon', '$dst/icon' );
        syncDirectory( 'res/font', '$dst/font' );
        syncDirectory( 'res/image', '$dst/image' );

        syncFile( 'res/chrome/manifest.json', '$dst/manifest.json' );
        syncFile( 'res/chrome/screensaver.html', '$dst/screensaver.html' );
        syncFile( 'res/chrome/settings.html', '$dst/settings.html' );
    }
}
