#include "networkquerycontroller.hpp"
#include <stdexcept>
#include <QNetworkReply>
#include <QImageWriter>
#include <QImage>
#include <QDebug>

QImage imageFromByteArray( const QByteArray& ba  )
{
  QImage image;
  image.loadFromData( ba, "PNG" );
  return image;
}

NetworkQueryController::NetworkQueryController( QObject* parent ) : QObject( parent )
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

void NetworkQueryController::runRequest( const QStringList& attributes, const QString& query )
{
  qDebug() << Q_FUNC_INFO << query;

  try {
    auto request = QNetworkRequest( query );
    request.setAttribute( QNetworkRequest::Attribute::User, QVariant( attributes ) );
    mNetworkAccessManager.get( request );
  } catch ( std::exception const& e ) {
    qWarning() << Q_FUNC_INFO << e.what();
    emit networkQueryFailed( QString{e.what()} );
  }
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
    case QueryType::SaveImage:
      saveToFile( networkReply->readAll(), attributes[1] );
    }

  } catch ( std::exception const& e ) {
    qWarning() << Q_FUNC_INFO << e.what();
    emit networkQueryFailed( e.what() );
  }

  networkReply->deleteLater();
}

void NetworkQueryController::saveToFile( const QByteArray& source, const QString& destination ) const
{
  auto filename{destination};
  filename.replace( "file://", "" );
  //qDebug() << Q_FUNC_INFO << destination << " ->  " << filename;
  QImageWriter writer( filename );

  if ( !writer.write( imageFromByteArray( source ) ) ) {
    QString message( "Unable to save as " + filename );
    throw  std::runtime_error( message.toStdString() );
  }
}
