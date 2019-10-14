#include "networkquerycontroller.hpp"
#include <stdexcept>
#include <QNetworkReply>
#include <QDebug>


NetworkQueryController::NetworkQueryController( QObject* parent ) : QObject( parent )
{

}

void NetworkQueryController::runRequest( const QString& query, const QStringList& attributes )
{
  //qDebug() << Q_FUNC_INFO << query;
  //  http://localhost:60564/test/?quasiPeriodicStripes
  try {
    auto request = QNetworkRequest( query );
    request.setAttribute( QNetworkRequest::Attribute::User, QVariant( attributes ) );
    mNetworkAccessManager.get( request );
  } catch ( std::exception const& e ) {
    qWarning() << Q_FUNC_INFO << e.what();
    emit networkQueryFailed( QString{e.what()} );
  }
}
