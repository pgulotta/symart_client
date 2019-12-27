#include "networkquerycontroller.hpp"
#include <stdexcept>
#include <QNetworkReply>
#include <QImageWriter>
#include <QImage>
#include <QStandardPaths>
#include <QDir>
#include <QBuffer>
#include <QUuid>


QImage imageFromByteArray( const QByteArray& ba )
{
  QImage image;
  image.loadFromData( ba, "PNG" );
  return image;
}

NetworkQueryController::NetworkQueryController( QObject* parent )
  : QObject( parent ),
    mQueryPrefix{"http://172.104.28.183:60564/get/?"},
    mImageColorsPrefix{"http://172.104.28.183:60564/imageColors/?"},
    mServiceId{QUuid::createUuid().toString( QUuid::WithoutBraces )}
{
  connect( &mNetworkAccessManager,
           &QNetworkAccessManager::finished,
           this,
           &NetworkQueryController::onNetworkReply );
}
int NetworkQueryController::getNextResponseId()
{
  return mResponseId++;
}

QueryType NetworkQueryController::extractQueryType( const QStringList& attributes )
{
  return static_cast<QueryType>( attributes[0].toInt() );
}

void NetworkQueryController::runGetRequest( const QStringList& attributes, const QString& query )
{
// qDebug() << Q_FUNC_INFO << query;

  try {
    auto request = QNetworkRequest( query );
    request.setAttribute( QNetworkRequest::Attribute::User, QVariant( attributes ) );
    mNetworkAccessManager.get( request );
  } catch ( std::exception const& e ) {
    //qWarning() << Q_FUNC_INFO << e.what();
    emit networkQueryMessage( QString{e.what()} );
  }
}

void NetworkQueryController::runGenerateImageRequest( const QString& query )
{
  QStringList attributes{QString::number( static_cast<int>( QueryType::GenerateImage ) )};
  runGetRequest( attributes, query );
}

void NetworkQueryController::runSaveImageRequest( const QString& filenamePrefix, const QString& imageFileExtension )
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
  QString query = QString( "%1lastImage/%2" ).arg( mQueryPrefix ).arg( mServiceId );
  runGetRequest( attributes, query );
}

void NetworkQueryController::runLoadImageColorsRequest( const QString& query )
{
  QStringList attributes{QString::number( static_cast<int>( QueryType::ImageColors ) )};
  runGetRequest( attributes, query );
}

void NetworkQueryController::onNetworkReply( QNetworkReply* networkReply )
{
  try {
    if ( networkReply->error() ) {
      throw std::runtime_error( networkReply->errorString().toStdString().data() );
    }

    QStringList attributes
      = networkReply->request().attribute( QNetworkRequest::Attribute::User ).toStringList();

    switch ( extractQueryType( attributes ) ) {
    case QueryType::GenerateImage:
      emit newImageGenerated( new QImage( imageFromByteArray( networkReply->readAll() ) ) ) ;
      break;

    case QueryType::SaveImage:
      saveToFile( networkReply->readAll(), attributes[1] );
      break;

    case QueryType::ImageColors:
      //  qDebug() << Q_FUNC_INFO << networkReply->readAll();
      break;
    }

  } catch ( std::exception const& e ) {
    //qWarning() << Q_FUNC_INFO << e.what();
    emit networkQueryMessage( e.what() );
  }

  networkReply->deleteLater();
}

void NetworkQueryController::saveToFile( const QByteArray& source, const QString& destination ) const
{
  auto filename = QUrl::fromUserInput( destination ).toLocalFile();
  //qInfo() << Q_FUNC_INFO <<  "Local filename = " << filename;
  QImageWriter writer( filename );

  QString message;

  if ( writer.write( imageFromByteArray( source ) ) ) {
    message = ( "Saved image as " + filename );
  } else {
    message = "Unable to save image as " + filename + " - " + writer.errorString();
  }

  emit networkQueryMessage( message );
}
