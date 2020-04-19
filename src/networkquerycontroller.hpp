#pragma once

#include <QObject>
#include <QNetworkAccessManager>

enum class QueryType {
  GenerateImage,
  SaveImage,
  GetWallpaperImage,
  ImageColors
};

class NetworkQueryController final : public QObject
{
  Q_OBJECT
signals:
  void networkQueryMessage( QString messageDescription ) const;
  void newImageGenerated( const QImage* newImage ) const;

public:
  explicit NetworkQueryController( QObject* parent = nullptr );
  void runGenerateImageRequest(  const QString& query ) ;
  void runLoadImageColorsRequest(  const QString& query ) ;
  void runSaveImageRequest( const QString& filenamePrefix, const QString& imageFileExtension ) ;
  void runSaveImageAsWallpaperRequest() ;
  const QString& queryPrefix() { return mQueryPrefix;}
  const QString& imageColorsPrefix() { return mImageColorsPrefix;}
  const QString& serviceId() { return mServiceId;}

private slots:
  void onNetworkReply( QNetworkReply* networkReply );

private:
  void runGetRequest( const QStringList& attributes, const QString& query ) ;
  int getNextResponseId();
  QueryType extractQueryType( const QStringList& attributes );
  void saveToFile( const QByteArray& source,  const QString& destination ) const;
  QNetworkAccessManager mNetworkAccessManager;
  int mResponseId{0};
  const QString mQueryPrefix;
  const QString mImageColorsPrefix;
  const QString mServiceId;
};




