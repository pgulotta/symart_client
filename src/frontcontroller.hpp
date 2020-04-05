#pragma once
#include "imageprovider.hpp"
#include "networkquerycontroller.hpp"
#include <QObject>
#include <QImage>


class QQmlApplicationEngine;

class FrontController final : public QObject
{
  Q_OBJECT
signals:
  void messageGenerated( QString messageDescription ) const;
  void imageGenerated();

public slots:


public:
  explicit FrontController( QObject* parent = nullptr );
  static void appMessageHandler( QtMsgType type, const QMessageLogContext& context, const QString& msg );
  ImageProvider* imageProvider() { return  mImageProvider;}

  #ifdef Q_OS_ANDROID
  Q_INVOKABLE void scheduleGenerateWallpaper() const;
  Q_INVOKABLE void cancelWallpaperSchedule() const;
  #endif

  Q_INVOKABLE QString applicationTitle() const;
  Q_INVOKABLE QString applicationVersion() const;
  Q_INVOKABLE QString toLocalFile( const QString& fileURL ) const;

  Q_INVOKABLE void saveCurrentImage( const QString& filenamePrefix, const QString& imageFileExtension ) ;
  Q_INVOKABLE void loadColorsImage( const QString& colorImagePath );
  Q_INVOKABLE void getLastGenerateImage();
  Q_INVOKABLE void generateHexagonalStretchImage();
  Q_INVOKABLE void generateCloudsImage( int dimension, int symmetryGroup, QColor color1, QColor color2, QColor color3,
                                        int distributionIndex );
  Q_INVOKABLE void generateHyperbolicCloudsImage( int dimension, int symmetryGroup, int projType,
                                                  int distributionIndex,
                                                  int rotation0, int rotation1, int rotation2, int rotation3,
                                                  QColor color1, QColor color2, QColor color3 );
  Q_INVOKABLE void generateOrbitTrapImage( QColor color, int dimension, int symmetryGroup );
  Q_INVOKABLE void generateClustersImage( int dimension, int symmetryGroup, double alpha );
  Q_INVOKABLE void generateStripesImage( int dimension, int symmetryGroup, double alpha );
  Q_INVOKABLE void generateQuasiperiodicStripesImage( int dimension, int quasiperiod, double alpha );
  Q_INVOKABLE void generateRandomizeImage( int x, int y );
  Q_INVOKABLE void generateHyperbolicImage( int size,  int projectionType );
  Q_INVOKABLE void generateWalkImage( int width, int height, int mode,  bool isBalanced,  bool isTileable );
  Q_INVOKABLE void generateSquigglesImage( int colorCount, int dimension, int symmetryGroup, double alpha,
                                           double exponent, double thickness, double sharpness );
  Q_INVOKABLE void generateSquigglesImage( int colorCount, double saturationBoost,
                                           bool useHue, bool useSaturation, bool useLightness,
                                           int dimension, int symmetryGroup, double alpha, double exponent,
                                           double thickness, double sharpness );
  Q_INVOKABLE void updateSquigglesImage( int dimension, int symmetryGroup );

  Q_INVOKABLE void generateLinessImage( int dimension, int symmetryGroup, int colorCount,
                                        const QString& ruleName1, int ruleWeight1, bool usePastelColors1,
                                        const QString& ruleName2, int ruleWeight2, bool usePastelColors2,
                                        const QString& ruleName3, int ruleWeight3, bool usePastelColors3 );

  Q_INVOKABLE void generateHyperbolicLinesImage( int dimension, int fdfIndex, int rotation0, int rotation1,
                                                 int rotation2, int rotation3, int projType, int flipType,
                                                 double thickness, double sharpness, int colorCount );

  Q_INVOKABLE void generateQuasiTrapImage( QColor color, int functionIndex,  int width, int height,
                                           int symmetryValueIndex, double quasiperiod );

private:

  NetworkQueryController mNetworkQueryController;
  ImageProvider* mImageProvider;  // qml releases this resource
  static FrontController* FrontControllerInstance;


};




