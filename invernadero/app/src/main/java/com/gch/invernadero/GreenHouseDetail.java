package com.gch.invernadero;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.gch.invernadero.adapters.GreenHouseAdapter;
import com.gch.invernadero.model.GreenHouseVo;
import com.gch.invernadero.model.PlantVo;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class GreenHouseDetail extends AppCompatActivity implements Response.Listener<JSONObject>, Response.ErrorListener {
    Toolbar toolbar;
    String idinvernadero = "";
    ProgressDialog progressDialog;
    Util util = new Util();
    RequestQueue requestQueue;
    JsonObjectRequest jsonObjectRequest;

    TextView lblLocation;
    TextView lblSize;
    TextView lblWidth;
    TextView lblHeight;
    TextView lblIdPlant;
    TextView lblNamePlant;
    TextView lblDatePlant;
    TextView lblLarge;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        setTheme(R.style.AppTheme);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_green_house_detail);
        init();
        toolbar = (Toolbar) findViewById(R.id.toolbarGreenHousesDetail);
        setSupportActionBar(toolbar);
        //agrega la flecha para regresar en toolbar
        toolbar.setNavigationIcon(R.drawable.ic_arrow_back);
        final Intent intent = new Intent(GreenHouseDetail.this, GreenHouse.class);
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(intent);
            }
        });

        //recuperar variables de la actividad gastos o ingresos
        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            idinvernadero = extras.getString("idinvernadero");

            loadGreenHouseDetail(idinvernadero);

        }
    }


    private void loadGreenHouseDetail(String id) {
        progressDialog = new ProgressDialog(GreenHouseDetail.this);
        progressDialog.setMessage("Cargando...");
        progressDialog.show();

        String URL = util.getHost() + "/wsJSONConsultarGreenHouseUrl.php?idinvernadero=" + id;

        jsonObjectRequest = new JsonObjectRequest(Request.Method.GET, URL, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {
                progressDialog.hide();

                GreenHouseVo greenHouseVo = new GreenHouseVo();
                PlantVo plantVo = new PlantVo();

                JSONArray json = response.optJSONArray("invernaderoplanta");
                JSONObject jsonObject = null;

                try {
                    jsonObject = json.getJSONObject(0);
                    greenHouseVo.setIdinvernadero(jsonObject.optInt("idinvernadero"));
                    greenHouseVo.setUbicacioninvernadero(jsonObject.optString("ubicacioninvernadero"));
                    greenHouseVo.setTamanoinvernadero(jsonObject.optString("tamanoinvernadero"));
                    greenHouseVo.setAlturainvernadero(jsonObject.optDouble("alturainvernadero"));
                    greenHouseVo.setAnchoinvernadero(jsonObject.optDouble("anchoinvernadero"));
                    greenHouseVo.setLargoinvernadero(jsonObject.optDouble("largoinvernadero"));
                    greenHouseVo.setMaterialinvernadero(jsonObject.optDouble("materialinvernadero"));

                    plantVo.setIdplanta(jsonObject.optInt("idplanta"));
                    plantVo.setNombreplanta(jsonObject.optString("nombreplanta"));
                    plantVo.setNombrecientificoplanta(jsonObject.optString("nombrecienificoplanta"));
                    plantVo.setFechasiembraplanta(jsonObject.optString("fechasiembraplanta"));
                    plantVo.setAturamaxplanta(jsonObject.optString("aturamaxplanta"));
                } catch (JSONException e) {
                    e.printStackTrace();
                }

                lblLocation.setText(greenHouseVo.getUbicacioninvernadero());
               lblSize.setText(greenHouseVo.getTamanoinvernadero());
               lblWidth.setText(greenHouseVo.getAnchoinvernadero().toString());
                lblHeight.setText(greenHouseVo.getAlturainvernadero().toString());
                lblLarge.setText(greenHouseVo.getLargoinvernadero().toString());

                lblNamePlant.setText(plantVo.getNombreplanta());
                lblDatePlant.setText(plantVo.getFechasiembraplanta());

             //   lblIdPlant.setText(plantVo.getIdplanta());



            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(GreenHouseDetail.this, "No se puede conectar " + error.toString(), Toast.LENGTH_LONG).show();
                System.out.println();
                progressDialog.hide();
                Log.d("ERROR: ", error.toString());
            }
        });

        // request.add(jsonObjectRequest);
        VolleySingleton.getIntanciaVolley(GreenHouseDetail.this).addToRequestQueue(jsonObjectRequest);
    }

    @Override
    public void onErrorResponse(VolleyError error) {
    }

    @Override
    public void onResponse(JSONObject response) {
    }

    private void init() {
        lblLocation = (TextView) findViewById(R.id.lblLocation);
        lblSize = (TextView) findViewById(R.id.lblSize);
       lblWidth = (TextView) findViewById(R.id.lblWidth);
        lblHeight = (TextView) findViewById(R.id.lblHeightPlant);
      lblNamePlant = (TextView) findViewById(R.id.lblNamePlant);
        lblDatePlant = (TextView) findViewById(R.id.lblDatePlant);
        lblLarge = (TextView) findViewById(R.id.lblLarge);

    }
}
