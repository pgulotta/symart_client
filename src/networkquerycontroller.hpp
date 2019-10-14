#pragma once


#include <QObject>
#include <QNetworkAccessManager>

class NetworkQueryController : public QObject
{
  Q_OBJECT

signals:
  void networkQueryFailed( QString messageDescription );

public slots:

public:
  explicit NetworkQueryController( QObject* parent = nullptr );

  void runRequest( const QString& query, const QStringList& attributes );






private:
  QNetworkAccessManager mNetworkAccessManager;
};


