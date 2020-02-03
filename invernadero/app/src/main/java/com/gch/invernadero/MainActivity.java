package com.gch.invernadero;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    Button btnGoToPhotoCapture;
    Button btnGoToFrmAdd;
   // Button btnGoToPhotoInit;
    Button btnGoToListGreenHouse;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        setTheme(R.style.AppTheme);

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        btnGoToPhotoCapture = (Button) findViewById(R.id.btnGoToPhotoCapture);
        btnGoToFrmAdd = (Button) findViewById(R.id.btnGoToFrmAdd);
       // btnGoToPhotoInit = (Button) findViewById(R.id.btnGoToPhotoInit);
        btnGoToListGreenHouse = (Button) findViewById(R.id.btnGoToListGreenHouse);
        btnGoToPhotoCapture.setOnClickListener(this);
        btnGoToFrmAdd.setOnClickListener(this);
     //   btnGoToPhotoInit.setOnClickListener(this);
        btnGoToListGreenHouse.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        Intent intent = null;
        switch (v.getId()) {
            case R.id.btnGoToPhotoCapture:
                intent = new Intent(this, PhotoCapture.class);
                break;
            case R.id.btnGoToFrmAdd:
                intent = new Intent(this, Plant.class);
                break;
           /* case R.id.btnGoToPhotoInit:
                intent = new Intent(this, PhotoInit.class);
                break;*/
                case R.id.btnGoToListGreenHouse:
                intent = new Intent(this, GreenHouse.class);
                break;
        }
        if (intent != null) {
            startActivity(intent);
        }
    }
}
