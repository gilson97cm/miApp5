package com.gch.invernadero.adapters;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.recyclerview.widget.RecyclerView;

import com.gch.invernadero.R;
import com.gch.invernadero.Util;
import com.gch.invernadero.model.GreenHouseVo;

import java.util.ArrayList;
import java.util.List;

public class GreenHouseAdapter extends RecyclerView.Adapter<GreenHouseAdapter.GreenHouseViewHolder> implements View.OnClickListener{
    private List<GreenHouseVo> mDataset; //ArrayList<GreenHouseVo> mDataset;
    private List<GreenHouseVo> mDatasetFull;
    private View.OnClickListener listener;

    // Provide a suitable constructor (depends on the kind of dataset)
    public GreenHouseAdapter(List<GreenHouseVo> myDataset) { // public GreenHouseAdapter(ArrayList<GreenHouseVo> myDataset) {
        this.mDataset = myDataset;
        this.mDatasetFull = new ArrayList<>(mDataset);
    }

    // Create new views (invoked by the layout manager)
    @Override
    public GreenHouseViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        // creamos una vista nueva
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.list_greeen_houses, null, false);
        view.setOnClickListener(this);
        return new GreenHouseViewHolder(view);
    }

    // Replace the contents of a view (invoked by the layout manager)
    @Override
    public void onBindViewHolder(GreenHouseViewHolder holder, int position) {
        //asignamos los datos al cardView
        holder.txtLocation.setText(mDataset.get(position).getUbicacioninvernadero().toString());
        holder.txtAlto.setText(mDataset.get(position).getAlturainvernadero().toString());
        holder.txtAncho.setText(mDataset.get(position).getAnchoinvernadero().toString());


    }

    // Return the size of your dataset (invoked by the layout manager)
    @Override
    public int getItemCount() {
        return mDataset.size();
    }

    //filtrar usuarios
    public void setFilter(ArrayList<GreenHouseVo> dealList_) {
        this.mDataset = new ArrayList<>();
        this.mDataset.addAll(dealList_);
        notifyDataSetChanged();
    }

    @Override
    public void onClick(View v) {
        if (listener!=null){
            listener.onClick(v);
        }

    }

    public void setOnClickListener(View.OnClickListener listener){
        this.listener=listener;
    }


    public static class GreenHouseViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        Context context;

        // dentro de esta clase hay que hacer referencia a los items que aparezcan en nuestro item (elemento de la lista)

        TextView txtLocation;
        TextView txtAlto;
        TextView txtAncho;

        GreenHouseViewHolder(View v) {
            super(v);
            context = v.getContext();
            txtLocation = (TextView) v.findViewById(R.id.txtLocation);
            txtAlto = (TextView) v.findViewById(R.id.txtAlto);
            txtAncho = (TextView) v.findViewById(R.id.txtAncho);

        }

        @Override
        public void onClick(View v) {

        }
    }
}
