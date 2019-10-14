#pragma once

#include "networkquerycontroller.hpp"
#include <QObject>
#include <QImage>


class QQmlApplicationEngine;

class FrontController : public QObject
{
  Q_OBJECT
signals:

public slots:


public:
  explicit FrontController( QObject* parent = nullptr );

  Q_INVOKABLE QString applicationTitle() const;
  Q_INVOKABLE QString applicationVersion() const;
  Q_INVOKABLE QImage generateTrap( int dimension, int symmetryGroup );

private:
  const QString serviceId;
  NetworkQueryController mNetworkQueryController;


};


