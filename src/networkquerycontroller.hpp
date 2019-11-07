#pragma once

#include <QObject>
#include <QNetworkAccessManager>

enum class QueryType {
  SaveImage,
  ImageColors
};

class NetworkQueryController final : public QObject
{
  Q_OBJECT
signals:
  void networkQueryMessage( QString messageDescription ) const;

public:
  explicit NetworkQueryController( QObject* parent = nullptr );
  void runGetRequest( const QStringList& attributes, const QString& query ) ;

private slots:
  void onNetworkReply( QNetworkReply* networkReply );

private:
  int getNextResponseId();
  QueryType extractQueryType( const QStringList& attributes );
  void saveToFile( const QByteArray& source,  const QString& destination ) const;
  QNetworkAccessManager mNetworkAccessManager;
  int mResponseId{0};

};




