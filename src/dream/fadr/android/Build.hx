package dream.fadr.android;

import om.io.FileSync.*;

class Build {

    static function app() {

        syncDirectory( 'res/font', 'build/android/font' );
        //syncDirectory( 'res/image', 'build/chrome/image' );

        syncFile( 'res/android/dream.html', 'build/android/dream.html' );
        syncFile( 'res/android/settings.html', 'build/android/settings.html' );
    }
}
