package com.twentysixapps.symart;

import android.util.Log;
import android.app.job.JobInfo;
import android.app.job.JobScheduler;
import android.content.ComponentName;
import android.content.Context;


public final class WallpaperGeneratorJobScheduler
{
  private static final String ID = WallpaperGeneratorJobService.ID;
  private static final int JOB_ID =  60564;
  private static final long FIFTEEN_MINUTES_INTERVAL_MS =  900000L;
  private static final long HOURLY_INTERVAL_MS =  3600000L;   // 3600000L;
  private static final long DAILY_INTERVAL_MS = 43200000L;   // 43200000L; (half day)

  private static void handleJob ( Context context, long interval, boolean shouldCancel )
  {
    if ( context == null ) {
      Log.e ( ID, "WallpaperGeneratorJobScheduler.handleJob context is null" );
      return;
    }

    try {
      ComponentName serviceComponent = new ComponentName( context, WallpaperGeneratorJobService.class );

      if ( serviceComponent == null ) {
        Log.e ( ID, "WallpaperGeneratorJobScheduler.handleJob serviceComponent = null " );
        return;
      }

      JobScheduler jobScheduler = context.getSystemService( JobScheduler.class );

      if ( jobScheduler == null ) {
        Log.e ( ID, "WallpaperGeneratorJobScheduler.scheduleJob jobScheduler = null " );
        return;
      }

      jobScheduler.cancel( JOB_ID );

      if ( shouldCancel ) {
        Log.i ( ID, "WallpaperGeneratorJobScheduler.scheduleJob cancelled " );
        return;
      }

      JobInfo.Builder builder = new JobInfo.Builder( JOB_ID, serviceComponent );

      if ( builder == null ) {
        Log.e ( ID, "builder.scheduleJob builder = null " );
        return;
      }

      //builder.setOverrideDeadline( interval + 120000); // maximum scheduling latency; API 21
      //builder.setMinimumLatency( interval ); //  delay job by the provided amount of time in ms; API 21
      builder.setPeriodic( interval );  // job should run within the provided interval; API 21
      builder.setPersisted( true ); // persist this job across device reboots; API 21
      builder.setRequiredNetworkType( JobInfo.NETWORK_TYPE_ANY ); // requires network connectivity; API 21
      builder.setRequiresDeviceIdle(false); // the job is runnable even when someone is interacting with the device; API 21
      int result = jobScheduler.schedule( builder.build() );
      String resultText = ( JobScheduler.RESULT_SUCCESS == result ) ? "successfully" : "failed";
      Log.i ( ID, "WallpaperGeneratorJobScheduler.scheduleJob scheduled for interval of " + interval + " is "  + resultText );

    } catch ( Exception e ) {
      e.printStackTrace();
    }
  }

  public static void cancelJob ( Context context )
  {
    handleJob( context, 0, true );
  }

  public static void scheduleHourlyJob ( Context context )
  {
    handleJob( context, HOURLY_INTERVAL_MS, false );
  }

  public static void scheduleDailyJob ( Context context )
  {
    handleJob( context, DAILY_INTERVAL_MS, false );
  }

  public static void scheduleFifteenMinutesJob ( Context context )
  {
    handleJob( context, FIFTEEN_MINUTES_INTERVAL_MS, false );
  }


}
