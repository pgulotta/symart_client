
package com.twentysixapps.symart;

import android.util.Log;
import android.content.Context;
import android.content.Intent;
import android.os.Environment;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.graphics.BitmapFactory;
import android.app.WallpaperManager;
import android.util.Base64;
import java.lang.StringBuilder;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.BufferedInputStream;
import java.io.OutputStream;
import java.io.InputStream;
import java.io.ByteArrayOutputStream;



public class WallpaperGenerator implements Runnable
{
  public static final String REQUEST_METHOD = "GET";
  public static final int READ_TIMEOUT = 15000;
  public static final int CONNECTION_TIMEOUT = 15000;
  private final String ID = WallpaperGeneratorJobService.ID;
  private Context mContext;

  public WallpaperGenerator( Context context )
  {
    mContext = context;
  }

  @Override
  public void run()
  {
    try {
      byte[] array = getWallpaper();

      if ( array.length == 0 ) {
        Log.e( ID, "WallpaperGenerator.doWork failed. Wallpaper array is empty" );
        return;
      }

      setWallpaper( array );
    } catch ( Exception e ) {
      e.printStackTrace();
    }
  }

  private byte[] getWallpaper(  )
  {
    Log.i( ID, "WallpaperGenerator.getWallpaper called" );
    ByteArrayOutputStream responseBody = new ByteArrayOutputStream();
    HttpURLConnection connection = null;
    InputStream stream = null;

    try {
      URL url = new URL( "http://192.168.1.119:60564/test?quasiTrap" );
      //URL url = new URL( "http://192.168.1.119:60564/test?squiggles" );
      Log.i( ID, "WallpaperGenerator.getWallpaper:  url = " + url );
      connection = ( HttpURLConnection ) url.openConnection();

      if ( connection == null ) {
        Log.e( ID, "WallpaperGenerator.getWallpaper:  connection= null" );
        return responseBody.toByteArray();
      }

      connection.setRequestMethod( REQUEST_METHOD );
      connection.setReadTimeout( READ_TIMEOUT );
      connection.setConnectTimeout( CONNECTION_TIMEOUT );
      connection.connect();

      stream = connection.getInputStream();

      if ( stream == null ) {
        Log.e( ID, "WallpaperGenerator.getWallpaper:  stream= null" );
        return responseBody.toByteArray();
      }


      byte buffer[] = new byte[1024];
      int bytesRead = 0;

      while ( ( bytesRead = stream.read( buffer ) ) > 0 ) {
        responseBody.write( buffer, 0, bytesRead );
      }

      connection.disconnect();
      stream.close();
    } catch ( Exception e ) {
      e.printStackTrace();
    }

    return responseBody.toByteArray();
  }

  private void setWallpaper( byte[] array )
  {
    Log.i( ID, "WallpaperGenerator.setWallpaper called" );

    try {

      if ( array.length == 0 ) {
        Log.e( ID, "WallpaperGenerator.setWallpaper:  array is empty" );
        return;
      }

      Log.i( ID, "WallpaperGenerator.setWallpaper:  array length = " + array.length );


      Bitmap destinationBitmap =  BitmapFactory.decodeByteArray( array, 0, array.length );

      if ( destinationBitmap == null ) {
        Log.e( ID, "WallpaperGenerator.setWallpaper: destinationBitmap = null" );
        return;
      }

      Log.i( ID, "WallpaperGenerator.setWallpaper: destinationBitmap getWidth = " + destinationBitmap.getWidth() );

      if ( mContext == null ) {
        Log.e( ID, "WallpaperGenerator.setWallpaper: mContext is null" );
        return;
      }

      WallpaperManager   wallpaperManager = WallpaperManager.getInstance ( mContext );

      if ( wallpaperManager == null ) {
        Log.e( ID, "WallpaperGenerator.setWallpaper: wallpaperManager = null" );
        return;
      }

      Log.i( ID, "WallpaperGenerator.setWallpaper: destinationBitmap width = " + destinationBitmap.getWidth() );
      wallpaperManager.setBitmap ( destinationBitmap );

    } catch ( IOException e ) {
      e.printStackTrace();
    } catch ( Exception ex ) {
      ex.printStackTrace();
    }

  }

}

//   http://127.0.0.1:60564/test?lines
//   http://127.0.0.1:60564/test?quasiPeriodicStripes
//   http://127.0.0.1:60564/test?quasiTrap
//   http://127.0.0.1:60564/test?quasiTrapPoly
//   http://127.0.0.1:60564/test?walk2
//   http://127.0.0.1:60564/test?trap
//   http://127.0.0.1:60564/test?stripes
//   http://127.0.0.1:60564/test?squiggles



