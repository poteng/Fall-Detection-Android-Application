package reuiot2015.smartwatch;

import android.app.Activity;
//import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class DialogActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dialog);
        this.setFinishOnTouchOutside(true);
    }

    public void ButtonDialogPositive(View view)
    {
        //do something
    }

    public void ButtonDialogNegative(View view)
    {
        finish();
    }


}
