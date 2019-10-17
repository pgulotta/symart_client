#pragma once

#include <QObject>
#include <QNetworkAccessManager>

enum class QueryType {
  SaveImage
};

class NetworkQueryController final : public QObject
{
  Q_OBJECT
signals:
  void networkQueryFailed( QString messageDescription );


public:
  explicit NetworkQueryController( QObject* parent = nullptr );
  void runRequest( const QStringList& attributes, const QString& query ) ;

private slots:
  void onNetworkReply( QNetworkReply* networkReply );

private:
  int getNextResponseId();
  QueryType extractQueryType( const QStringList& attributes );
  void saveToFile( const QByteArray& source,  const QString& destination ) const;
  QNetworkAccessManager mNetworkAccessManager;
  int mResponseId{0};

};




