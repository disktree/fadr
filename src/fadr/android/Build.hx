package fadr.android;

import om.io.FileSync.*;

class Build {

    static function app() {

        var dst = 'build/android';

        syncDirectory( 'res/font', '$dst/font' );
        syncDirectory( 'res/image', '$dst/image' );

        syncFile( 'res/android/dream.html', '$dst/dream.html' );
        syncFile( 'res/android/settings.html', '$dst/settings.html' );
    }
}
