#include "querycontroller.hpp"
#include <stdexcept>
#include <QNetworkReply>
#include <QImageWriter>
#include <QImage>
#include <QStandardPaths>
#include <QDir>
#include <QBuffer>
#include <QUuid>
#include <QtConcurrent/QtConcurrentRun>
#ifdef Q_OS_ANDROID
#include <QAndroidJniObject>
#include <QAndroidJniEnvironment>
#include <QtAndroid>
#endif


#ifdef QT_DEBUG
const QString WALLPAPER_SERVER = "http://192.168.1.121:60564/";
#else
const QString WALLPAPER_SERVER = "http://65.60.187.8:60564/";
#endif

QImage imageFromByteArray( const QByteArray& ba )
{
  QImage image;
  image.loadFromData( ba, "PNG" );
  return image;
}

QueryController::QueryController( QObject* parent )
  : QObject( parent ),
    mQueryPrefix{WALLPAPER_SERVER + "get/?"},
    mImageColorsPrefix{WALLPAPER_SERVER + "imageColors/?"},
    mServiceId{QUuid::createUuid().toString( QUuid::WithoutBraces )}
{
  connect( &mNetworkAccessManager,
           &QNetworkAccessManager::finished,
           this,
           &QueryController::onNetworkReply );
}


int QueryController::getNextResponseId()
{
  return mResponseId++;
}

QueryType QueryController::extractQueryType( const QStringList& attributes )
{
  return static_cast<QueryType>( attributes[0].toInt() );
}

void QueryController::runGetRequest( const QStringList& attributes, const QString& query )
{
  //qDebug() << Q_FUNC_INFO << query;

  try {
    auto request = QNetworkRequest( query );
    request.setAttribute( QNetworkRequest::Attribute::User, QVariant( attributes ) );
    mNetworkAccessManager.get( request );
  } catch ( std::exception const& e ) {
    qWarning() << Q_FUNC_INFO << e.what();
    emit networkQueryMessage( QString{e.what()} );
  }
}

void QueryController::runModifyImageRequest( const QString& query )
{
  QStringList attributes{QString::number( static_cast<int>( QueryType::ModifyImage ) )};
  runGetRequest( attributes, query );
}

void QueryController::runGenerateImageRequest( const QString& query )
{
  QStringList attributes{QString::number( static_cast<int>( QueryType::GenerateImage ) )};
  runGetRequest( attributes, query );
}

void QueryController::runSaveImageAsWallpaperRequest()
{
  const QDir dir = QStandardPaths::writableLocation( QStandardPaths::DownloadLocation );

  auto saveFilename =  QString( "%1%2symart_wallpaper.png" )
                       .arg( dir.path() )
                       .arg( QDir::separator() ) ;

  qInfo() << Q_FUNC_INFO << saveFilename;

  QStringList attributes{QString::number( static_cast<int>( QueryType::ImageAsWallpaper ) ),
                         saveFilename};
  QString query = QString( "%1lastImage/%2" ).arg( mQueryPrefix ).arg( mServiceId );
  runGetRequest( attributes, query );
}

void QueryController::runSaveImageRequest( const QString& filenamePrefix, const QString& imageFileExtension )
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
  qInfo() << Q_FUNC_INFO << saveFilename;
  QStringList attributes{QString::number( static_cast<int>( QueryType::SaveImage ) ),
                         saveFilename};
  QString query = QString( "%1lastImage/%2" ).arg( mQueryPrefix ).arg( mServiceId );
  runGetRequest( attributes, query );
}

void QueryController::onNetworkReply( QNetworkReply* networkReply )
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

    case QueryType::ModifyImage:
      emit modifiedImageGenerated( new QImage( imageFromByteArray( networkReply->readAll() ) ) ) ;
      break;

    case QueryType::SaveImage:
      QtConcurrent::run( this, &QueryController::saveToFile, networkReply->readAll(), attributes[1], true );
      break;

    case QueryType::ImageAsWallpaper:
      QtConcurrent::run( this, &QueryController::saveImageAsWallpaper, networkReply->readAll(), attributes[1] );
      break;
    }
  } catch ( std::exception const& e ) {
    qWarning() << Q_FUNC_INFO << e.what();
    emit networkQueryMessage( e.what() );
  }

  networkReply->deleteLater();
}

#ifdef Q_OS_ANDROID
void QueryController::saveImageAsWallpaper( const QByteArray& source,
                                            const QString& wallpaperFilename ) const
{
  saveToFile( source, wallpaperFilename, false );
  setWallpaperUsingFile();
}

void QueryController::setWallpaperUsingFile() const
{
  QAndroidJniObject::callStaticMethod<void>( "com/twentysixapps/symart/WallpaperGenerator",
                                             "setWallpaperUsingFile",
                                             "(Landroid/content/Context;)V",
                                             QtAndroid::androidActivity().object() );
}
#else
void QueryController::setWallpaperUsingFile() const
{
}
void QueryController::saveImageAsWallpaper( const QByteArray&, const QString& ) const {}
#endif

void QueryController::saveToFile( const QByteArray& source, const QString& destination,
                                  bool shouldSendMessage ) const
{
  auto filename = QUrl::fromUserInput( destination ).toLocalFile();

  QImageWriter writer( filename );
  QString message;

  if ( writer.write( imageFromByteArray( source ) ) ) {
    message = ( "Saved image as " + filename );
  } else {
    message = "Unable to save image as " + filename + " - " + writer.errorString();
  }

  qInfo() << Q_FUNC_INFO <<  message;

  if ( shouldSendMessage ) {
    emit networkQueryMessage( message );
  }
}

