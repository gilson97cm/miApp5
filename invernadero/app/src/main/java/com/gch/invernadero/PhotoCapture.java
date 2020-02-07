package com.gch.invernadero;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.core.content.FileProvider;

import android.Manifest;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.media.MediaScannerConnection;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;


import android.os.Environment;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.ImageRequest;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.gch.invernadero.model.MarketVo;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class PhotoCapture extends AppCompatActivity implements View.OnClickListener, Response.Listener<JSONObject>, Response.ErrorListener, AdapterView.OnItemSelectedListener {
    final int REQUEST_CODE_GALLERY = 999;
    Toolbar toolbar;
    ImageView photoCapture;
    ImageView photoCharge;
    Button btnCapture;
    Button btnCharge;
    Button btnCompare;
    Button btnFail;
    Button btnError;
    Spinner spinner;
    ProgressDialog progressDialog;
    RequestQueue requestQueue;
    JsonObjectRequest jsonObjectRequest;


    List<String> lisMarketString;
    List<MarketVo> MarketLisObject;

    String currentPhotoPath;
    static final int REQUEST_TAKE_PHOTO = 1;
    static final int REQUEST_IMAGE_CAPTURE = 1;

    private static final String CARPETA_PRINCIPAL = "DCIM/";//directorio principal
    private static final String CARPETA_IMAGEN = "invernadero";//carpeta donde se guardan las fotos
    private static final String DIRECTORIO_IMAGEN = CARPETA_PRINCIPAL + CARPETA_IMAGEN;//ruta carpeta de directorios
    private String path;//almacena la ruta de la imagen
    File fileImagen;
    Bitmap bitmap;

    private final int MIS_PERMISOS = 100;
    private static final int COD_SELECCIONA = 10;
    private static final int COD_FOTO = 20;
    ProgressDialog progreso;
    StringRequest stringRequest;
    Util util;
    String data[] = {"hola", "spinner"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        setTheme(R.style.AppTheme);

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_photo_capture);
        init();
        setSupportActionBar(toolbar);
        util = new Util();
        lisMarketString = new ArrayList<String>();
        MarketLisObject = new ArrayList<>();

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

        //solicitar permisos
        if (ContextCompat.checkSelfPermission(PhotoCapture.this, Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(PhotoCapture.this, Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(PhotoCapture.this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.CAMERA}, 1000);
        }

        requestQueue = Volley.newRequestQueue(PhotoCapture.this);
        loadMarkets();

    }

    private void loadMarkets() {
        progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Cargando...");
        progressDialog.show();

        String URL = util.getHost() + "/wsJSONConsultarMarkets.php";

        jsonObjectRequest = new JsonObjectRequest(Request.Method.GET, URL, null, this, this);
        //requestQueue.add(jsonObjectRequest);
        VolleySingleton.getIntanciaVolley(this).addToRequestQueue(jsonObjectRequest);
    }

    @Override
    public void onErrorResponse(VolleyError error) {
        Toast.makeText(this, "No se puede conectar. " + error.toString(), Toast.LENGTH_SHORT).show();
        System.out.println();
        Log.d("ERROR", error.toString());
        progressDialog.hide();
    }

    @Override
    public void onResponse(JSONObject response) {
        MarketVo marketVo = null;
        JSONArray json = response.optJSONArray("mercados");

        try {
            // assert json != null;
            for (int i = 0; i < json.length(); i++) {
                marketVo = new MarketVo();
                JSONObject jsonObject = null;
                jsonObject = json.getJSONObject(i);
                marketVo.setId_mercado(jsonObject.optInt("id_mercado"));
                marketVo.setTipo_mercado(jsonObject.optString("tipo_mercado"));
                marketVo.setRutafoto_mercado(jsonObject.optString("rutafoto_mercado"));
                MarketLisObject.add(marketVo);
            }
            progressDialog.hide();
            //lisMarketString.add("Seleccione..");
            for (int i = 0; i < MarketLisObject.size(); i++) {
                lisMarketString.add("" + MarketLisObject.get(i).getTipo_mercado());
            }
            ArrayAdapter<CharSequence> adapter = new ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, lisMarketString);
            spinner.setAdapter(adapter);
            spinner.setOnItemSelectedListener(this);

        } catch (JSONException e) {
            e.printStackTrace();
            Toast.makeText(this, "No se ha podido establecer conexión con el servidor" +
                    " " + response, Toast.LENGTH_LONG).show();
            progressDialog.hide();
        }

    }

    private void cargarWebServiceImagen(String urlImagen) {
        urlImagen=urlImagen.replace(" ","%20");

        ImageRequest imageRequest=new ImageRequest(urlImagen, new Response.Listener<Bitmap>() {
            @Override
            public void onResponse(Bitmap response) {
                bitmap=response;//SE MODIFICA
                photoCharge.setImageBitmap(response);
            }
        }, 0, 0, ImageView.ScaleType.CENTER, null, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(getApplicationContext(),"Error al cargar la imagen",Toast.LENGTH_SHORT).show();
                Log.i("ERROR IMAGEN","Response -> "+error);
            }
        });
        //  request.add(imageRequest);
        VolleySingleton.getIntanciaVolley(this).addToRequestQueue(imageRequest);
    }

    private File createImageFile() throws IOException {
        // Create an image file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "Backup_" + timeStamp + "_";
        File storageDir = getExternalFilesDir(Environment.DIRECTORY_PICTURES);
        File image = File.createTempFile(
                imageFileName,
                ".jpg",
                storageDir
        );
        // Save a file: path for use with ACTION_VIEW intents
        currentPhotoPath = image.getAbsolutePath();
        return image;
    }


    private void abriCamara() {
        File miFile = new File(Environment.getExternalStorageDirectory(), DIRECTORIO_IMAGEN);
        boolean isCreada = miFile.exists();

        if (isCreada == false) {
            isCreada = miFile.mkdirs();
        }

        if (isCreada == true) {
            Long consecutivo = System.currentTimeMillis() / 1000;
            String nombre = consecutivo.toString() + ".jpg";

            path = Environment.getExternalStorageDirectory() + File.separator + DIRECTORIO_IMAGEN
                    + File.separator + nombre;//indicamos la ruta de almacenamiento

            fileImagen = new File(path);

            Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
            intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(fileImagen));

            ////
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                String authorities = this.getPackageName() + ".provider";
                Uri imageUri = FileProvider.getUriForFile(this, authorities, fileImagen);
                intent.putExtra(MediaStore.EXTRA_OUTPUT, imageUri);
            } else {
                intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(fileImagen));
            }
            startActivityForResult(intent, COD_FOTO);

        }
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btnCharge:
                choseImg();
                break;
            case R.id.btnCapture:
                // takePhoto();

                abriCamara();
                break;
            case R.id.btnCompare:
                msgSuccess();
                break;
            case R.id.btnFail:
                msgFail();
                break;
            case R.id.btnError:
                msgError();
                break;
        }
    }

    //cargar imagen de la galeria
    public void choseImg() {
        //  ActivityCompat.requestPermissions(PhotoCapture.this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, REQUEST_CODE_GALLERY);
        Intent intent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
        intent.setType("image/*");
        startActivityForResult(intent.createChooser(intent, "Seleccione"), COD_SELECCIONA);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (requestCode == REQUEST_CODE_GALLERY) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                Intent intent = new Intent(Intent.ACTION_PICK);
                intent.setType("image/*");
                startActivityForResult(intent, REQUEST_CODE_GALLERY);
            } else {
                Toast.makeText(this, "Sin acceso.", Toast.LENGTH_SHORT).show();
            }
            return;
        }
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
      /*  if(requestCode == REQUEST_CODE_GALLERY && resultCode == RESULT_OK && data != null){
            Uri uri = data.getData();
            try {
                InputStream inputStream = getContentResolver().openInputStream(uri);
                Bitmap bitmap = BitmapFactory.decodeStream(inputStream);

                photoCharge.setImageBitmap(bitmap);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
        }

        if (requestCode == REQUEST_IMAGE_CAPTURE && resultCode == RESULT_OK) {
              Bundle extras = data.getExtras();
              Bitmap imageBitmap = (Bitmap) extras.get("data");
              photoCapture.setImageBitmap(imageBitmap);
        }*/
        super.onActivityResult(requestCode, resultCode, data);
        switch (requestCode) {
            case COD_SELECCIONA:
                Uri miPath = data.getData();
                photoCharge.setImageURI(miPath);

                try {
                    bitmap = MediaStore.Images.Media.getBitmap(PhotoCapture.this.getContentResolver(), miPath);
                    photoCharge.setImageBitmap(bitmap);
                } catch (IOException e) {
                    e.printStackTrace();
                }

                break;
            case COD_FOTO:
                MediaScannerConnection.scanFile(PhotoCapture.this, new String[]{path}, null,
                        new MediaScannerConnection.OnScanCompletedListener() {
                            @Override
                            public void onScanCompleted(String path, Uri uri) {
                                Log.i("Path", "" + path);
                            }
                        });

                bitmap = BitmapFactory.decodeFile(path);
                photoCapture.setImageBitmap(bitmap);

                break;
        }
        bitmap = redimensionarImagen(bitmap, 600, 800);
    }

    private Bitmap redimensionarImagen(Bitmap bitmap, float anchoNuevo, float altoNuevo) {

        int ancho = bitmap.getWidth();
        int alto = bitmap.getHeight();

        if (ancho > anchoNuevo || alto > altoNuevo) {
            float escalaAncho = anchoNuevo / ancho;
            float escalaAlto = altoNuevo / alto;

            Matrix matrix = new Matrix();
            matrix.postScale(escalaAncho, escalaAlto);

            return Bitmap.createBitmap(bitmap, 0, 0, ancho, alto, matrix, false);

        } else {
            return bitmap;
        }
    }

    private void msgSuccess() {
        msg("¡Exito!", "Estado: Cosecha");

    }

    private void msgFail() {
        msg("¡Alerta!", "Estado: Precosecha");

    }

    private void msgError() {
        msg("!Error¡", "No hay coincidencias");
    }

    private void msg(String title, String msg) {
        AlertDialog.Builder builder = new AlertDialog.Builder(PhotoCapture.this);
        builder.setTitle(title);
        builder.setMessage(msg);
        builder.setPositiveButton("ok", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
            }
        });
        AlertDialog dialog = builder.create();
        dialog.show();
    }

    private void init() {
        // requestQueue = Volley.newRequestQueue(this);
        toolbar = (Toolbar) findViewById(R.id.toolbarPhotoCapture);
        photoCapture = (ImageView) findViewById(R.id.photoCapture);
        photoCharge = (ImageView) findViewById(R.id.photoCharge);
        btnCapture = (Button) findViewById(R.id.btnCapture);
        btnCharge = (Button) findViewById(R.id.btnCharge);
        btnCompare = (Button) findViewById(R.id.btnCompare);
        btnFail = (Button) findViewById(R.id.btnFail);
        btnError = (Button) findViewById(R.id.btnError);
        spinner = (Spinner) findViewById(R.id.spinner);

        onClick();
    }

    private void onClick() {
        btnCapture.setOnClickListener(this);
        btnCharge.setOnClickListener(this);
        btnCompare.setOnClickListener(this);
        btnFail.setOnClickListener(this);
        btnError.setOnClickListener(this);
    }


    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        String idM = MarketLisObject.get(position).getId_mercado().toString();

        String urlImagen=util.getHost()+"/"+MarketLisObject.get(position).getRutafoto_mercado();
        //Toast.makeText(getContext(), "url "+urlImagen, Toast.LENGTH_LONG).show();
        cargarWebServiceImagen(urlImagen);

       // Toast.makeText(this, "ID:" + idM, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }


}
