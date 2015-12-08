package disktree.net.fadr;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.webkit.WebSettings;
import android.webkit.WebSettings.LayoutAlgorithm;
import android.webkit.WebView;

public class SettingsActivity extends Activity {

    protected WebView webview;
    protected int systemUiFlags;

    protected SettingsActivity( int systemUiFlags ) {
        super();
        this.systemUiFlags = systemUiFlags;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate( savedInstanceState );

        this.requestWindowFeature( Window.FEATURE_NO_TITLE );

        setContentView( R.layout.activity_settings );

        webview = (WebView) findViewById(R.id.webview);
        webview.setBackgroundColor(0x00000000);
        webview.clearCache(true);
        webview.setInitialScale(0);
        //webview.setLayerType(View.LAYER_TYPE_HARDWARE,null);
        //webview.setVerticalScrollBarEnabled(false);

        WebSettings settings = webview.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setAllowContentAccess(true);
        settings.setAllowFileAccess(true);
        settings.setAllowFileAccessFromFileURLs(true);
        settings.setDomStorageEnabled( true );
        settings.setUseWideViewPort( true );
        settings.setLayoutAlgorithm(LayoutAlgorithm.NORMAL);

        //webview.addJavascriptInterface( new WebApp(this), "AndroidApp" );
    }

    @Override
    public void onResume() {
        super.onResume();
        getWindow().getDecorView().setSystemUiVisibility( systemUiFlags );
    }

    protected void loadWebApp(String id) {
        webview.loadUrl( "file:///android_asset/"+id+".html" );
    }

    protected void setupUi(int i) {
        getWindow().getDecorView().setSystemUiVisibility(i);
    }

    /*
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate( R.menu.meta, menu );
        return super.onCreateOptionsMenu( menu );
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch( item.getItemId() ) {
            case R.id.action_github:
                openURI( getString( R.string.action_github_uri ) );
                return true;
            case R.id.action_chrome:
                openURI( getString( R.string.action_chrome_uri ) );
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
    */

    protected void openURI( String uri ) {
        Intent intent = new Intent( Intent.ACTION_VIEW, Uri.parse( uri ) );
        startActivity( intent );
    }
}
