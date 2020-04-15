package com.twentysixapps.symart;

import android.util.Log;
import android.app.job.JobInfo;
import android.app.job.JobScheduler;
import android.content.ComponentName;
import android.content.Context;


public class WallpaperGeneratorJobScheduler
{
  private static final String ID = WallpaperGeneratorJobService.ID;
  private static final int JOB_ID =  60564;
  private static final long FIFTEEN_MINUTES_INTERVAL_MS = 300000l;   // 900000L;
  private static final long HOURLY_INTERVAL_MS =  3600000L;   // 3600000L;
  private static final long DAILY_INTERVAL_MS = 43200000L;   // 43200000L; (half day)

  private static void handleJob ( Context context, long interval, boolean shouldCancel )
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

      jobScheduler.cancel( JOB_ID );

      if ( shouldCancel ) {
        Log.i ( ID, "WallpaperGeneratorJobScheduler.scheduleJob cancelled " );
        return;
      }

      JobInfo.Builder builder = new JobInfo.Builder( JOB_ID, serviceComponent );

      if ( builder == null ) {
        Log.i ( ID, "builder.scheduleJob builder = null " );
        return;
      }

      //  builder.setPeriodic( interval );  // job should run within the provided interval
      builder.setOverrideDeadline( interval ); // maximum scheduling latency
      builder.setMinimumLatency( interval ); //  delay job by the provided amount of time in ms
      builder.setPersisted( true ); // persist this job across device reboots
      builder.setRequiredNetworkType( JobInfo.NETWORK_TYPE_ANY );  // the kind of network your job requires
      int result = jobScheduler.schedule( builder.build() );
      String resultText = ( JobScheduler.RESULT_SUCCESS == result ) ? "successfully" : "failed";
      Log.i ( ID, "WallpaperGeneratorJobScheduler.scheduleJob scheduled for interval of " + interval + " is "  + resultText );

    } catch ( Exception e ) {
      e.printStackTrace();
    }
  }

  public static void cancelJob ( Context context )
  {
    Log.i ( ID, "WallpaperGeneratorJobScheduler.cancelJob called" );
    handleJob( context, 0, true );
  }

  public static void scheduleHourlyJob ( Context context )
  {
    Log.i ( ID, "WallpaperGeneratorJobScheduler.scheduleHourlyJob called" );
    handleJob( context, HOURLY_INTERVAL_MS, false );
  }

  public static void scheduleDailyJob ( Context context )
  {
    Log.i ( ID, "WallpaperGeneratorJobScheduler.scheduleDailyJob called" );
    handleJob( context, DAILY_INTERVAL_MS, false );
  }

  public static void scheduleFifteenMinutesJob ( Context context )
  {
    Log.i ( ID, "WallpaperGeneratorJobScheduler.scheduleFifteenMinutesJob called" );
    handleJob( context, FIFTEEN_MINUTES_INTERVAL_MS, false );
  }


}
