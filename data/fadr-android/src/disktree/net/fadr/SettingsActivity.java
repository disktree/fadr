package disktree.net.fadr;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.webkit.WebSettings;
import android.webkit.WebSettings.LayoutAlgorithm;
import android.webkit.WebView;

public class SettingsActivity extends Activity {

    private WebView webview;

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate( savedInstanceState );

        this.requestWindowFeature( Window.FEATURE_NO_TITLE );

        getWindow().getDecorView().setSystemUiVisibility( View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY | View.SYSTEM_UI_FLAG_FULLSCREEN );

        setContentView( R.layout.activity_settings );

        webview = (WebView) findViewById(R.id.webview);
        //webview.setBackgroundColor(0x00000000);
        //webview.setLayerType(View.LAYER_TYPE_HARDWARE,null);
        webview.clearCache(true);
        webview.setInitialScale(0);
        //webview.setVerticalScrollBarEnabled(false);

        WebSettings settings = webview.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setAllowContentAccess(true);
        settings.setAllowFileAccess(true);
        settings.setAllowFileAccessFromFileURLs(true);
        settings.setDomStorageEnabled( true );
        settings.setUseWideViewPort( true );
        settings.setLayoutAlgorithm(LayoutAlgorithm.NORMAL);

        webview.loadUrl( "file:///android_asset/settings.html" );
    }
}
