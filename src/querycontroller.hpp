#pragma once

#include <QObject>
#include <QNetworkAccessManager>

class ImageProvider;

enum class QueryType {
  GenerateImage,
  ModifyImage
};

class QueryController final : public QObject
{
  Q_OBJECT
signals:
  void networkQueryMessage( QString messageDescription ) const;
  void newImageGenerated( const QImage* newImage ) const;
  void modifiedImageGenerated( const QImage* newImage ) const;


public:
  explicit QueryController( QObject* parent = nullptr );
  void runGenerateImageRequest(  const QString& query ) ;
  void runModifyImageRequest(  const QString& query ) ;
  void saveCurrentImage( const ImageProvider* imageProvider, const QString& filenamePrefix,
                         const QString& imageFileExtension ) ;
  void setCurrentImageAsWallpaper( const ImageProvider* imageProvider ) ;
  const QString& queryPrefix() { return mQueryPrefix;}
  const QString& imageColorsPrefix() { return mImageColorsPrefix;}
  const QString& serviceId() { return mServiceId;}

private slots:
  void onNetworkReply( QNetworkReply* networkReply );

private:
  void runGetRequest( const QStringList& attributes, const QString& query ) ;
  int getNextResponseId();
  QueryType extractQueryType( const QStringList& attributes );
  void saveToFile( const QByteArray& source,  const QString& destination, bool shouldSendMessage ) const;
  void setWallpaper( const QByteArray& source, const QString& wallpaperFilename ) const;
  void setWallpaperUsingFile(  ) const;
  QNetworkAccessManager mNetworkAccessManager;
  int mResponseId{0};
  const QString mQueryPrefix;
  const QString mImageColorsPrefix;
  const QString mServiceId;
};




