package com.twentysixapps.symart;

import android.app.job.JobParameters;
import android.app.job.JobService;
import android.os.Build;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.content.Context;
import android.content.Intent;


public class WallpaperGeneratorJobService extends JobService
{
  public static final String ID = "com.twentysixapps.symart";
  private static final int MSG_JOB = 60564;

  public static void scheduleDailyGenerateWallpaper( Context context )
  {
    Log.i( ID, "WallpaperGeneratorJobService.scheduleDailyGenerateWallpaper called" );
    context.startService( new Intent( context, WallpaperGeneratorJobService.class ) );

    try {
      WallpaperGeneratorJobScheduler.scheduleDailyJob( context );
    } catch ( Exception e ) {
      e.printStackTrace();
    }
  }

public static void scheduleHourlyGenerateWallpaper( Context context )
{
  Log.i( ID, "WallpaperGeneratorJobService.scheduleHourlyGenerateWallpaper called" );
  context.startService( new Intent( context, WallpaperGeneratorJobService.class ) );

  try {
    WallpaperGeneratorJobScheduler.scheduleHourlyJob( context );
  } catch ( Exception e ) {
    e.printStackTrace();
  }
}

public static void cancelWallpaperSchedule( Context context )
{
  Log.i( ID, "WallpaperGeneratorJobService.cancelWallpaperSchedule called" );
  context.startService( new Intent( context, WallpaperGeneratorJobService.class ) );

  try {
    WallpaperGeneratorJobScheduler.cancelJob( context );
  } catch ( Exception e ) {
    e.printStackTrace();
  }
}

  @Override
  public boolean onStartJob( JobParameters jobParameters )
  {
    Log.i( ID, "WallpaperGeneratorJobService.onStartJob : jobParameters.getJobId() = " + jobParameters.getJobId() );

    try {
      Thread thread = new Thread( new WallpaperGenerator( this ) );
      thread.start();
      thread.join();
      Log.i( ID, "WallpaperGeneratorJobService.onStartJob : thread has been joined " );
    } catch ( Exception e ) {
      e.printStackTrace();
    } finally {
      jobFinished(jobParameters, true);

      Log.i( ID, "WallpaperGeneratorJobService.onStartJob : jobFinished called " );
    }

    return true;  // Returns false from when job has finished
  }

  @Override
  public boolean onStopJob( JobParameters jobParameters )
  {
    Log.i( ID, "WallpaperGeneratorJobService.onStopJob : jobParameters.getJobId() = " + jobParameters.getJobId() );
    // Return true to have the job rescheduled, false to drop it
    return true;
  }


}


