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
  Q_INVOKABLE QString toLocalFile( const QString& fileURL ) const;

  Q_INVOKABLE void saveCurrentImage( const QString& filenamePrefix, const QString& imageFileExtension ) ;
  Q_INVOKABLE void loadColorsImage( const QString& colorImagePath );
  Q_INVOKABLE QString getLastGenerateImageQuery();
  Q_INVOKABLE QString getHexagonalStretchImageQuery();
  Q_INVOKABLE QString getCloudsQuery( int dimension, int symmetryGroup, QColor color1, QColor color2, QColor color3,
                                      int distributionIndex );
  Q_INVOKABLE QString getHyperbolicCloudsQuery( int dimension, int symmetryGroup, int projType, int distributionIndex,
                                                int rotation0, int rotation1, int rotation2, int rotation3,
                                                QColor color1, QColor color2, QColor color3 );
  Q_INVOKABLE QString getOrbitTrapQuery( QColor color, int dimension, int symmetryGroup );
  Q_INVOKABLE QString getClustersQuery( int dimension, int symmetryGroup, double alpha );
  Q_INVOKABLE QString getStripesQuery( int dimension, int symmetryGroup, double alpha );
  Q_INVOKABLE QString getQuasiperiodicStripesQuery( QColor color, int dimension, int quasiperiod, double alpha );
  Q_INVOKABLE QString getRandomizeQuery( int x, int y );
  Q_INVOKABLE QString getHyperbolicImageQuery( int size,  int projectionType );
  Q_INVOKABLE QString getWalkImageQuery( int width, int height, int mode,  bool isBalanced,  bool isTileable );
  Q_INVOKABLE QString getSquigglesQuery( int colorCount, int dimension, int symmetryGroup, double alpha, double exponent,
                                         double thickness, double sharpness );
  Q_INVOKABLE QString getSquigglesQuery( int colorCount, double saturationBoost,
                                         bool useHue, bool useSaturation, bool useLightness,
                                         int dimension, int symmetryGroup, double alpha, double exponent,
                                         double thickness, double sharpness );
  Q_INVOKABLE QString getSquigglesUpdateQuery( int dimension, int symmetryGroup );

  Q_INVOKABLE QString getLinessQuery( int dimension, int symmetryGroup, int colorCount,
                                      const QString& ruleName1, int ruleWeight1, bool usePastelColors1,
                                      const QString& ruleName2, int ruleWeight2, bool usePastelColors2,
                                      const QString& ruleName3, int ruleWeight3, bool usePastelColors3 );

  Q_INVOKABLE QString getHyperbolicLines( int dimension, int fdfIndex, int rotation0, int rotation1,
                                          int rotation2, int rotation3, int projType, int flipType,
                                          double thickness, double sharpness, int colorCount );

  Q_INVOKABLE QString getQuasiTrapQuery( QColor color, int functionIndex,  int width, int height, int symmetryValueIndex,
                                         double quasiperiod );

private:
  QString mServiceId;
  NetworkQueryController mNetworkQueryController;
  static FrontController* FrontControllerInstance;


};




