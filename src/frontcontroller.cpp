#include "frontcontroller.hpp"
#include <QApplication>
#include <QUuid>
#include <QStandardPaths>
#include <QDir>
#include <QDebug>


FrontController* FrontController::FrontControllerInstance{nullptr};

const QString QueryPrefix{"http://192.168.1.119:60564/get/?"};

//  const QString QueryPrefix{"http://192.168.1.119:60564/get/?"};

void FrontController::appMessageHandler( QtMsgType type,
                                         const QMessageLogContext& context,
                                         const QString& msg )
{
  QByteArray localMsg = msg.toLocal8Bit();
  const char* file = context.file ? context.file : "";
  const char* function = context.function ? context.function : "";
  auto displayMsg = msg.split( ':', QString::SkipEmptyParts );

  switch ( type ) {
  case QtDebugMsg:
    fprintf( stderr,
             "SymArt Debug: %s (%s:%u, %s)\n",
             localMsg.constData(),
             file,
             context.line,
             function );
    break;

  case QtInfoMsg:
    fprintf( stderr,
             "SymArt Info: %s (%s:%u, %s)\n",
             localMsg.constData(),
             file,
             context.line,
             function );
    break;

  case QtWarningMsg:
    fprintf( stderr,
             "SymArt Warning: %s (%s:%u, %s)\n",
             localMsg.constData(),
             file,
             context.line,
             function );
    emit FrontControllerInstance->messageGenerated( displayMsg[displayMsg.count() - 1] );
    break;

  case QtCriticalMsg:
    fprintf( stderr,
             "SymArt Critical: %s (%s:%u, %s)\n",
             localMsg.constData(),
             file,
             context.line,
             function );
    emit FrontControllerInstance->messageGenerated( displayMsg[displayMsg.count() - 1] );
    break;

  case QtFatalMsg:
    fprintf( stderr,
             "SymArt Fatal: %s (%s:%u, %s)\n",
             localMsg.constData(),
             file,
             context.line,
             function );
    emit FrontControllerInstance->messageGenerated( displayMsg[displayMsg.count() - 1] );
    break;
  }
}

FrontController::FrontController( QObject* parent )
  : QObject( parent )
  ,

    mServiceId{QUuid::createUuid().toString( QUuid::WithoutBraces )}
  , mNetworkQueryController( parent )
{
  FrontControllerInstance = this;
  qInstallMessageHandler( FrontController::appMessageHandler );
  connect( &mNetworkQueryController,
           &NetworkQueryController::networkQueryMessage,
           this,
  []( const QString & messageDescription ) {
    emit FrontControllerInstance->messageGenerated( messageDescription );
  } );
}

QString FrontController::applicationTitle() const
{
  return QApplication::applicationName();
}

QString FrontController::applicationVersion() const
{
  return QApplication::applicationVersion();
}

void FrontController::saveCurrentImage(  const QString& filenamePrefix, const QString& imageFileExtension )
{
  auto formattedPrefix{filenamePrefix.simplified()};
  formattedPrefix.replace( " ", "" );
  const QDir dir = QStandardPaths::writableLocation( QStandardPaths::DownloadLocation );

  auto saveFilename =  QString( "%1%2%3_%4.%5" )
                       .arg( dir.path() )
                       .arg( QDir::separator() )
                       .arg( formattedPrefix )
                       .arg( QUuid::createUuid().toString( QUuid::WithoutBraces ) )
                       .arg( imageFileExtension ) ;

  QStringList attributes{QString::number( static_cast<int>( QueryType::SaveImage ) ),
                         saveFilename};
  QString query = QString( "%1lastImage/%2" ).arg( QueryPrefix ).arg( mServiceId );
  mNetworkQueryController.runRequest( attributes, query );
}

QString FrontController::getOrbitTrapQuery( int dimension, int symmetryGroup )
{
  return QString( "%1trap/%2/%3/%4" )
         .arg( QueryPrefix )
         .arg( mServiceId )
         .arg( dimension )
         .arg( symmetryGroup );
}

QString FrontController::getClustersQuery( int dimension, int symmetryGroup, double alpha )
{
  return QString( "%1clusters/%2/%3/%4/%5" )
         .arg( QueryPrefix )
         .arg( mServiceId )
         .arg( dimension )
         .arg( symmetryGroup )
         .arg( alpha );
}

QString FrontController::getStripesQuery( int dimension, int symmetryGroup, double alpha )
{
  return QString( "%1stripes/%2/%3/%4/%5" )
         .arg( QueryPrefix )
         .arg( mServiceId )
         .arg( dimension )
         .arg( symmetryGroup )
         .arg( alpha );
}

QString FrontController::getQuasiperiodicStripesQuery( int dimension, int quasiperiod, double alpha )
{
  return QString( "%1quasiPeriodicStripes/%2/%3/%4/%5" )
         .arg( QueryPrefix )
         .arg( mServiceId )
         .arg( dimension )
         .arg( quasiperiod )
         .arg( alpha );
}

QString FrontController::getRandomizeQuery( int x, int y )
{
  return QString( "%1randomizeTiles/%2/%3/%4" ).arg( QueryPrefix ).arg( mServiceId ).arg( x ).arg( y );
}

QString FrontController::getHyperbolicImageQuery( int size, int projectionType )
{
  return QString( "%1hyperbolicImage/%2/%3/%4" )
         .arg( QueryPrefix )
         .arg( mServiceId )
         .arg( size )
         .arg( projectionType );
}

QString FrontController::getLastGenerateImageQuery()
{
  return QString( "%1lastImage/%2" ).arg( QueryPrefix ).arg( mServiceId );
}

QString FrontController::getHexagonalStretchImageQuery()
{
  return QString( "%1hexagonalStretch/%2" ).arg( QueryPrefix ).arg( mServiceId );
}
