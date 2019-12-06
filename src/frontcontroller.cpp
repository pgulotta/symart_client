#include "frontcontroller.hpp"
#include "immutablelist.hpp"
#include <QGuiApplication>
#include <QBuffer>
#include <QTextCodec>
#include <QUuid>

FrontController* FrontController::FrontControllerInstance{nullptr};


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
    emit FrontControllerInstance->messageGenerated( localMsg.constData() );
    //emit FrontControllerInstance->messageGenerated( displayMsg[displayMsg.count() - 1] );
    break;

  case QtWarningMsg:
    fprintf( stderr,
             "SymArt Warning: %s (%s:%u, %s)\n",
             localMsg.constData(),
             file,
             context.line,
             function );
    emit FrontControllerInstance->messageGenerated( localMsg.constData() );
    //emit FrontControllerInstance->messageGenerated( displayMsg[displayMsg.count() - 1] );
    break;

  case QtCriticalMsg:
    fprintf( stderr,
             "SymArt Critical: %s (%s:%u, %s)\n",
             localMsg.constData(),
             file,
             context.line,
             function );
    emit FrontControllerInstance->messageGenerated( localMsg.constData() );
    //emit FrontControllerInstance->messageGenerated( displayMsg[displayMsg.count() - 1] );
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
  : QObject( parent ), mNetworkQueryController( parent )
{
  FrontControllerInstance = this;
  qInstallMessageHandler( FrontController::appMessageHandler );

  connect( &mNetworkQueryController,
           &NetworkQueryController::newImageGenerated,
           this,
  [this]( const QImage * newImage  ) {
    mImageProvider.setImage( newImage );
    emit imageGenerated();
  } );

  connect( &mNetworkQueryController,
           &NetworkQueryController::networkQueryMessage,
           this,
  []( const QString & messageDescription ) {
    emit FrontControllerInstance->messageGenerated( messageDescription );
  } );


}

QString FrontController::applicationTitle() const
{
  return QGuiApplication::applicationName();
}

QString FrontController::applicationVersion() const
{
  return QGuiApplication::applicationVersion();
}

QByteArray toByteArray( const QString& colorImagePath )
{
  QByteArray ba;
  QImage image{colorImagePath};

  if ( image.sizeInBytes() > 0 ) {
    QBuffer buffer( &ba );
    buffer.open( QIODevice::WriteOnly );
    image.save( &buffer, "PNG" );
  }

  return ba;
}

void FrontController::loadColorsImage( const QString& colorImagePath )
{
  QByteArray byteArray = toByteArray( colorImagePath  );
  QString query = QString( "%1%2" )
                  .arg( mNetworkQueryController.imageColorsPrefix() )
                  .arg( QTextCodec::codecForMib( 2259 )->toUnicode( byteArray ) );
  mNetworkQueryController.runLoadImageColorsRequest( query );

  //QString payload =  QTextCodec::codecForMib( 2259 )->toUnicode( byteArray );
  //qDebug() << "&&&&&&&&&&&&&&&  payload=" << payload;
// QImage image{fromByteArray( QTextCodec::codecForMib( 2259 )->fromUnicode( payload ) )};
  //qDebug() << "************** image.isNull()=" << image.isNull();
}

QString FrontController::toLocalFile( const QString& fileURL ) const
{
  return  QUrl::fromUserInput( fileURL ).toLocalFile();
}

void FrontController::saveCurrentImage(  const QString& filenamePrefix, const QString& imageFileExtension )
{
  mNetworkQueryController.runSaveImageRequest( filenamePrefix, imageFileExtension );
}

void FrontController::generateOrbitTrapImage( QColor color, int dimension, int symmetryGroup )
{
  auto query = QString( "%1trap/%2/%3/%4/%5/%6/%7" )
               .arg( mNetworkQueryController.queryPrefix() )
               .arg( mNetworkQueryController.serviceId() )
               .arg( color.red() )
               .arg( color.green() )
               .arg( color.blue() )
               .arg( dimension )
               .arg( symmetryGroup );
  mNetworkQueryController.runGenerateImageRequest( query );
}

QString FrontController::getClustersQuery( int dimension, int symmetryGroup, double alpha )
{
  return QString( "%1clusters/%2/%3/%4/%5" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() )
         .arg( dimension )
         .arg( symmetryGroup )
         .arg( alpha );
}

QString FrontController::getStripesQuery( int dimension, int symmetryGroup, double alpha )
{
  return QString( "%1stripes/%2/%3/%4/%5" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() )
         .arg( dimension )
         .arg( symmetryGroup )
         .arg( alpha );
}

QString FrontController::getQuasiperiodicStripesQuery( int dimension, int quasiperiod, double alpha )
{
  return QString( "%1quasiPeriodicStripes/%2/%3/%4/%5" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() )
         .arg( dimension )
         .arg( quasiperiod )
         .arg( alpha );
}

QString FrontController::getRandomizeQuery( int x, int y )
{
  return QString( "%1randomizeTiles/%2/%3/%4" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() )
         .arg( x ).arg( y );
}

QString FrontController::getHyperbolicImageQuery( int size, int projectionType )
{
  return QString( "%1hyperbolicImage/%2/%3/%4" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() )
         .arg( size )
         .arg( projectionType );
}

QString FrontController::getWalkImageQuery( int width, int height, int mode, bool isBalanced, bool isTileable )
{
  if ( isTileable )
    return QString( "%1walk/%2/%3/%4/%5/%6" )
           .arg( mNetworkQueryController.queryPrefix() )
           .arg( mNetworkQueryController.serviceId() )
           .arg( width )
           .arg( height )
           .arg( isBalanced )
           .arg( mode );
  else
    return QString( "%1walk2/%2/%3/%4/%5/%6" )
           .arg( mNetworkQueryController.queryPrefix() )
           .arg( mNetworkQueryController.serviceId() )
           .arg( width )
           .arg( height )
           .arg( isBalanced )
           .arg( mode );
}

QString FrontController::getSquigglesQuery( int colorCount, double saturationBoost,
                                            bool useHue, bool useSaturation, bool useLightness, int dimension, int symmetryGroup,
                                            double alpha, double exponent, double thickness, double sharpness )
{
  return QString(  "%1squigglesImageColors/%2/%3/%4/%5/%6/%7/%8/%9/%10/%11/%12/%13" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() )
         .arg( saturationBoost )
         .arg( useHue )
         .arg( useSaturation )
         .arg( useLightness )
         .arg( colorCount )
         .arg( dimension )
         .arg( symmetryGroup )
         .arg( alpha )
         .arg( exponent )
         .arg( thickness )
         .arg( sharpness );
}

QString FrontController::getSquigglesQuery( int colorCount, int dimension,   int symmetryGroup, double alpha,
                                            double exponent, double thickness, double sharpness )
{
  return QString( "%1squiggles/%2/%3/%4/%5/%6/%7/%8/%9" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() )
         .arg( colorCount )
         .arg( dimension )
         .arg( symmetryGroup )
         .arg( alpha )
         .arg( exponent )
         .arg( thickness )
         .arg( sharpness );
}

QString FrontController::getSquigglesUpdateQuery( int dimension, int symmetryGroup )
{
  return QString( "%1updateSquiggles/%2/%3/%4" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() )
         .arg( dimension )
         .arg( symmetryGroup );
}

QString FrontController::getLastGenerateImageQuery()
{
  return QString( "%1lastImage/%2" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() );
}

QString FrontController::getHexagonalStretchImageQuery()
{
  return QString( "%1hexagonalStretch/%2" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() );
}

void FrontController::generateCloudsImage( int dimension, int symmetryGroup, QColor color1, QColor color2,
                                           QColor color3,
                                           int distributionIndex )
{
  QString query = QString( "%1clouds/%2/%3/%4/%5/%6/%7/%8/%9/%10/%11/%12/%13/%14" )
                  .arg( mNetworkQueryController.queryPrefix() )
                  .arg( mNetworkQueryController.serviceId() )
                  .arg( dimension )
                  .arg( symmetryGroup )
                  .arg( color1.red() )
                  .arg( color1.green() )
                  .arg( color1.blue() )
                  .arg( color2.red() )
                  .arg( color2.green() )
                  .arg( color2.blue() )
                  .arg( color3.red() )
                  .arg( color3.green() )
                  .arg( color3.blue() )
                  .arg( distributionIndex );
  mNetworkQueryController.runGenerateImageRequest( query );
}

void FrontController::generateHyperbolicCloudsImage( int dimension, int symmetryGroup, int projType,
                                                     int distributionIndex, int rotation0, int rotation1, int rotation2, int rotation3,
                                                     QColor color1, QColor color2, QColor color3 )
{
  QString query =  QString( "%1hyperbolicClouds/%2/%3/%4/%5/%6/%7/%8/%9/%10/%11/%12/%13/%14/%15/%16/%17/%18/%19" )
                   .arg( mNetworkQueryController.queryPrefix() )
                   .arg( mNetworkQueryController.serviceId() )
                   .arg( dimension )
                   .arg( symmetryGroup )
                   .arg( rotation0 )
                   .arg( rotation1 )
                   .arg( rotation2 )
                   .arg( rotation3 )
                   .arg( projType )
                   .arg( color1.red() )
                   .arg( color1.green() )
                   .arg( color1.blue() )
                   .arg( color2.red() )
                   .arg( color2.green() )
                   .arg( color2.blue() )
                   .arg( color3.red() )
                   .arg( color3.green() )
                   .arg( color3.blue() )
                   .arg( distributionIndex );
  mNetworkQueryController.runGenerateImageRequest( query );
}

QString FrontController::getLinessQuery( int dimension, int symmetryGroup, int colorCount,
                                         const QString& ruleName1, int ruleWeight1, bool usePastelColors1,
                                         const QString& ruleName2, int ruleWeight2, bool usePastelColors2,
                                         const QString& ruleName3, int ruleWeight3, bool usePastelColors3 )
{
  return QString( "%1lines/%2/%3/%4/%5/%6/%7/%8/%9/%10/%11/%12/%13/%14" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() )
         .arg( dimension )
         .arg( symmetryGroup )
         .arg( colorCount )
         .arg( ruleName1 )
         .arg( ruleWeight1 )
         .arg( usePastelColors1 )
         .arg( ruleName2 )
         .arg( ruleWeight2 )
         .arg( usePastelColors2 )
         .arg( ruleName3 )
         .arg( ruleWeight3 )
         .arg( usePastelColors3 );

}

QString FrontController::getHyperbolicLines( int dimension, int fdfIndex, int rotation0, int rotation1, int rotation2,
                                             int rotation3, int projType, int flipType, double thickness, double sharpness, int colorCount )
{
  return QString( "%1hyperbolicLines/%2/%3/%4/%5/%6/%7/%8/%9/%10/%11/%12/%13" )
         .arg( mNetworkQueryController.queryPrefix() )
         .arg( mNetworkQueryController.serviceId() )
         .arg( dimension )
         .arg( fdfIndex )
         .arg( rotation0 )
         .arg( rotation1 )
         .arg( rotation2 )
         .arg( rotation3 )
         .arg( projType )
         .arg( flipType )
         .arg( thickness )
         .arg( sharpness )
         .arg( colorCount );
}

QString FrontController::getQuasiTrapQuery( QColor color, int functionIndex, int width, int height,
                                            int symmetryValueIndex,
                                            double quasiperiod )
{
  QString query;

  if (  ImmutableList::isPolynomialFunction( functionIndex ) ) {
    query = QString( "%1quasiTrapPoly/%2/%3/%4/%5/%6/%7/%8/%9" )
            .arg( mNetworkQueryController.queryPrefix() )
            .arg( mNetworkQueryController.serviceId() )
            .arg( color.red() )
            .arg( color.green() )
            .arg( color.blue() )
            .arg( width )
            .arg( height )
            .arg( symmetryValueIndex )
            .arg( quasiperiod );
  } else {
    query = QString( "%1quasiTrap/%2/%3/%4/%5/%6/%7/%8/%9" )
            .arg( mNetworkQueryController.queryPrefix() )
            .arg( mNetworkQueryController.serviceId() )
            .arg( color.red() )
            .arg( color.green() )
            .arg( color.blue() )
            .arg( width )
            .arg( height )
            .arg( symmetryValueIndex )
            .arg( quasiperiod );
  }

  return query;
}


