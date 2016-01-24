package disktree.net.fadr;

import android.content.Intent;
import android.provider.Settings;
import android.service.dreams.DreamService;
import android.view.View;
import android.view.WindowManager;
import android.webkit.WebSettings;
import android.webkit.WebView;

public class Daydream extends DreamService {

    static final boolean DEBUG = true;
    static final String TAG = "fadr";

    private WebView webview;

    @Override
    public void onDreamingStarted() {
        super.onDreamingStarted();
        log( "======= onDreamingStarted =======");
    }

    @Override
    public void onDreamingStopped() {
        super.onDreamingStopped();
        log( "======= onDreamingStopped =======");
    }

    @Override
    public void onAttachedToWindow() {

        super.onAttachedToWindow();

        log( "======= onAttachedToWindow =======");

        setFullscreen(true);
        setInteractive(false);

        setContentView(R.layout.daydream);

        getWindow().getDecorView().setSystemUiVisibility( View.SYSTEM_UI_FLAG_FULLSCREEN | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION );

        //WindowManager.LayoutParams layout = getWindow().getAttributes();
        //layout.screenBrightness = 0.1f;
        //getWindow().setAttributes( layout );

        /*
        Settings.System.putInt(this.getContentResolver(), Settings.System.SCREEN_BRIGHTNESS, 20);

        WindowManager.LayoutParams lp = getWindow().getAttributes();
        lp.screenBrightness =0.2f;// 100 / 100.0f;
        getWindow().setAttributes(lp);

        startActivity(new Intent(this,RefreshScreen.class));
        */

        webview = (WebView) findViewById(R.id.webview);
        webview.setBackgroundColor(0x00000000);
        webview.clearCache(true);

        WebSettings settings = webview.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setAllowContentAccess(true);
        settings.setAllowFileAccess(true);
        settings.setAllowFileAccessFromFileURLs(true);
        settings.setDomStorageEnabled( true );

        webview.loadUrl("file:///android_asset/dream.html");
    }

    @Override
    public void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        log( "======= onDetachedFromWindow =======");
    }

    private static final void log( String msg ) {
        if( DEBUG ){
            android.util.Log.d( TAG, msg );
        }
    }
}
