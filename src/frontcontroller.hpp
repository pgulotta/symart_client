#pragma once

#include "networkquerycontroller.hpp"
#include <QObject>
#include <QImage>


class QQmlApplicationEngine;

class FrontController final : public QObject
{
  Q_OBJECT
signals:
  void messageGenerated( QString messageDescription ) const;


public slots:


public:
  explicit FrontController( QObject* parent = nullptr );
  static void appMessageHandler( QtMsgType type, const QMessageLogContext& context, const QString& msg );

  Q_INVOKABLE QString applicationTitle() const;
  Q_INVOKABLE QString applicationVersion() const;

  Q_INVOKABLE void saveCurrentImage( const QString& filenamePrefix, const QString& imageFileExtension ) ;

  Q_INVOKABLE QString getLastGenerateImageQuery();
  Q_INVOKABLE QString getHexagonalStretchImageQuery();
  Q_INVOKABLE QString getCloudsQuery( int dimension, int symmetryGroup, QColor color1, QColor color2, QColor color3,
                                      int distributionIndex );
  Q_INVOKABLE QString getOrbitTrapQuery( int dimension, int symmetryGroup );
  Q_INVOKABLE QString getClustersQuery( int dimension, int symmetryGroup, double alpha );
  Q_INVOKABLE QString getStripesQuery( int dimension, int symmetryGroup, double alpha );
  Q_INVOKABLE QString getQuasiperiodicStripesQuery( int dimension, int quasiperiod, double alpha );
  Q_INVOKABLE QString getRandomizeQuery( int x, int y );
  Q_INVOKABLE QString getHyperbolicImageQuery( int size,  int projectionType );
  Q_INVOKABLE QString getWalkImageQuery( int width, int height, int mode,  bool isBalanced,  bool isTileable );
  Q_INVOKABLE QString getSquigglesQuery( int colorCount, int dimension, int symmetryGroup, double alpha, double exponent,
                                         double thickness, double sharpness );
  Q_INVOKABLE QString getSquigglesQuery( const QString& colorImagePath, int colorCount, double saturationBoost,
                                         bool useHue, bool useSaturation, bool useLightness,
                                         int dimension, int symmetryGroup, double alpha, double exponent,
                                         double thickness, double sharpness );

private:
  QString mServiceId;
  NetworkQueryController mNetworkQueryController;
  static FrontController* FrontControllerInstance;


};




