package com.gch.invernadero;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

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
import com.android.volley.toolbox.Volley;
import com.gch.invernadero.adapters.GreenHouseAdapter;
import com.gch.invernadero.model.GreenHouseVo;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;


    public class GreenHouse extends AppCompatActivity implements Response.Listener<JSONObject>, Response.ErrorListener {
    TextView txtName;
    RecyclerView recyclerGreenHouses;
    ArrayList<GreenHouseVo> listGreenHouses;
    ProgressDialog progressDialog;
    RequestQueue requestQueue;
    JsonObjectRequest jsonObjectRequest;
    Util util = new Util();
    Toolbar toolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        setTheme(R.style.AppTheme);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_green_house);

        toolbar = (Toolbar) findViewById(R.id.toolbarGreenHouses);
        setSupportActionBar(toolbar);
        //agrega la flecha para regresar en toolbar
        toolbar.setNavigationIcon(R.drawable.ic_arrow_back);
        final Intent intent = new Intent(getApplicationContext(), MainActivity.class);
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(intent);
            }
        });

        txtName = (TextView) findViewById(R.id.txtName);
        listGreenHouses = new ArrayList<>();
        recyclerGreenHouses = (RecyclerView) findViewById(R.id.recyclerGreenHouses);
        recyclerGreenHouses.setLayoutManager(new LinearLayoutManager(this));
        recyclerGreenHouses.setHasFixedSize(true);
        requestQueue = Volley.newRequestQueue(this);
        loadGreenHouses();


    }

    private void loadGreenHouses() {
        progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Cargando...");
        progressDialog.show();

        String URL = util.getHost() + "/wsJSONConsultarLista.php";

        jsonObjectRequest = new JsonObjectRequest(Request.Method.GET, URL, null, this, this);
        requestQueue.add(jsonObjectRequest);
       // VolleySingleton.getIntanciaVolley(this).addToRequestQueue(jsonObjectRequest);
    }

    @Override
    public void onResponse(JSONObject response) {
        GreenHouseVo greenHouseVo = null;
        JSONArray json = response.optJSONArray("invernaderos");
        try {
            // assert json != null;
            for (int i = 0; i < json.length(); i++) {
                greenHouseVo = new GreenHouseVo();
                JSONObject jsonObject = null;
                jsonObject = json.getJSONObject(i);
                greenHouseVo.setIdinvernadero(jsonObject.optInt("idinvernadero"));
                greenHouseVo.setUbicacioninvernadero(jsonObject.optString("ubicacioninvernadero"));
                greenHouseVo.setTamanoinvernadero(jsonObject.optString("tamanoinvernadero"));
                greenHouseVo.setAlturainvernadero(jsonObject.optDouble("alturainvernadero"));
                greenHouseVo.setAnchoinvernadero(jsonObject.optDouble("anchoinvernadero"));
                greenHouseVo.setLargoinvernadero(jsonObject.optDouble("largoinvernadero"));
                greenHouseVo.setMaterialinvernadero(jsonObject.optDouble("materialinvernadero"));

                listGreenHouses.add(greenHouseVo);
            }

            progressDialog.hide();
            GreenHouseAdapter adapter = new GreenHouseAdapter(listGreenHouses);
            recyclerGreenHouses.setAdapter(adapter);

            adapter.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    String id = listGreenHouses.get(recyclerGreenHouses.getChildAdapterPosition(v)).getIdinvernadero().toString();
                    Toast.makeText(GreenHouse.this, id, Toast.LENGTH_SHORT).show();
                    Intent intent = new Intent(GreenHouse.this, GreenHouseDetail.class);
                    intent.putExtra("idinvernadero",id);
                    startActivity(intent);
                }
            });

        } catch (JSONException e) {
            e.printStackTrace();
            Toast.makeText(this, "No se ha podido establecer conexión con el servidor" +
                    " " + response, Toast.LENGTH_LONG).show();
            progressDialog.hide();
        }


    }

    @Override
    public void onErrorResponse(VolleyError error) {
        Toast.makeText(this, "No se puede conectar. " + error.toString(), Toast.LENGTH_SHORT).show();
        System.out.println();
        Log.d("ERROR", error.toString());
        progressDialog.hide();
    }

}
