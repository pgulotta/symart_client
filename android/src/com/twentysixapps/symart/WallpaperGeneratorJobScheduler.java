package com.twentysixapps.symart;

import android.util.Log;
import android.app.job.JobInfo;
import android.app.job.JobScheduler;
import android.content.ComponentName;
import android.content.Context;


public class WallpaperGeneratorJobScheduler
{
  private static final String ID = WallpaperGeneratorJobService.ID;
  private static final long Interval_MS =  300000L;   //  4 h = 14400000 ms ;  5 m = 60000 ms
  private static final int JOB_ID =  60564; //  4 h = 14400000 ms ;  1 m = 60000 ms

  private static void handleJob ( Context context, boolean shouldCancel )
  {
    Log.i ( ID, "WallpaperGeneratorJobScheduler.handleJob called" );

    if ( context == null ) {
      Log.i ( ID, "WallpaperGeneratorJobScheduler.handleJob context is null" );
      return;
    }

    try {
      ComponentName serviceComponent = new ComponentName( context, WallpaperGeneratorJobService.class );

      if ( serviceComponent == null ) {
        Log.i ( ID, "WallpaperGeneratorJobScheduler.handleJob serviceComponent = null " );
        return;
      }

      JobScheduler jobScheduler = context.getSystemService( JobScheduler.class );

      if ( jobScheduler == null ) {
        Log.i ( ID, "WallpaperGeneratorJobScheduler.scheduleJob jobScheduler = null " );
        return;
      }

      if ( shouldCancel ) {
        jobScheduler.cancel( JOB_ID );
        Log.i ( ID, "WallpaperGeneratorJobScheduler.scheduleJob cancelled " );
        return;
      }

      JobInfo.Builder builder = new JobInfo.Builder( JOB_ID, serviceComponent );

      if ( builder == null ) {
        Log.i ( ID, "builder.scheduleJob builder = null " );
        return;
      }
      builder.setPeriodic( Interval_MS );  // this job should recur with the provided interval, not more than once per period
      builder.setPersisted( true ); // persist this job across device reboots
      builder.setRequiredNetworkType( JobInfo.NETWORK_TYPE_ANY );  // the kind of network your job requires
      int result = jobScheduler.schedule( builder.build() );
      String resultText = ( JobScheduler.RESULT_SUCCESS == result ) ? "successfully" : "failed";
      Log.i ( ID, "WallpaperGeneratorJobScheduler.scheduleJob scheduled " + resultText );

    } catch ( Exception e ) {
      e.printStackTrace();
    }
  }

  public static void cancelJob ( Context context )
  {
    Log.i ( ID, "WallpaperGeneratorJobScheduler.cancelJob called" );
    handleJob( context, true );
  }

  public static void scheduleJob ( Context context )
  {
    Log.i ( ID, "WallpaperGeneratorJobScheduler.scheduleJob called" );
    handleJob( context, false );
  }

}
