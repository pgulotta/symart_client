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
  Q_INVOKABLE void saveCurrentImage( const QString& filename ) ;
  Q_INVOKABLE QString getOrbitTrapQuery( int dimension, int symmetryGroup );
  Q_INVOKABLE QString getRandomizeQuery( int x, int y );
  Q_INVOKABLE QString getLastGenerateImageQuery();

private:
  QString mServiceId;
  NetworkQueryController mNetworkQueryController;
  static FrontController* FrontControllerInstance;


};


