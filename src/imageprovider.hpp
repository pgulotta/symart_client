#pragma once

#include <QQuickImageProvider>
#include <memory>


class ImageProvider : public QQuickImageProvider
{
public:
  ImageProvider();
  void setImage( const QImage* newImage );
  const QImage* getImage() {return mImage.get();}

  void setOriginalImage( const QImage* newImage );
  const QImage* getOriginalImage() {return mOriginalImage.get();}

  void setModifiedImage( const QImage* newImage );
  const QImage* getModifiedImage() {return mModifiedImage.get();}

  QImage requestImage( const QString& id, QSize* size, const QSize& requestedSize ) override;

private:
  std::unique_ptr<QImage> mImage;
  std::unique_ptr<QImage> mOriginalImage;
  std::unique_ptr<QImage> mModifiedImage;


};


