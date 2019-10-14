#pragma once

#include <QObject>
#include <QImage>


class QQmlApplicationEngine;

class FrontController final : public QObject
{
  Q_OBJECT
signals:
  void messageGenerated( QString messageDescription );


public slots:


public:
  explicit FrontController( QObject* parent = nullptr );
  static void appMessageHandler( QtMsgType type, const QMessageLogContext& context, const QString& msg );

  Q_INVOKABLE QString applicationTitle() const;
  Q_INVOKABLE QString applicationVersion() const;
  Q_INVOKABLE QString generateTrapQuery( int dimension, int symmetryGroup );

private:
  QString mServiceId;



};


