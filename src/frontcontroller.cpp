#include "frontcontroller.hpp"
#include <QApplication>
#include <QUuid>


FrontController::FrontController( QObject* parent ) :
  QObject( parent ),
  serviceId{QUuid::createUuid().toString()}
{

}

QString FrontController::applicationTitle() const
{
  return QApplication::applicationName();
}

QString FrontController::applicationVersion() const
{
  return QApplication::applicationVersion();
}


QImage FrontController::generateTrap( int dimension, int symmetryGroup )
{
  //  http://localhost:60564/test/?trap
  mNetworkQueryController.runRequest( "http://localhost:60564/test/?trap", QStringList{} );
  return QImage{};
}

