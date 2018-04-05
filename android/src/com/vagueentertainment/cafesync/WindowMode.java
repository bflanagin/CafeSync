import android.view.MenuItem;
import android.view.Menu;
import android.view.View;
import android.graphics.Color;

public class WindowMode extends org.qtproject.qt5.android.bindings.QtActivity
{
@Override
public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
       // if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
    if (hasFocus) {
        getWindow().getDecorView().setSystemUiVisibility(
            View.SYSTEM_UI_FLAG_LAYOUT_STABLE
            | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
            | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
            | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
            | View.SYSTEM_UI_FLAG_FULLSCREEN
            | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);
        }
   // }
}

}
