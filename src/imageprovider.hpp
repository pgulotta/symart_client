#pragma once

#include <QQuickImageProvider>
#include <memory>


class ImageProvider : public QQuickImageProvider
{
public:
  ImageProvider();
  QImage requestImage( const QString& id, QSize* size, const QSize& requestedSize ) override;

  const QImage* getDisplayImage() {return mDisplayImage.get();}

  void setOriginalImage( const QImage* newImage );
  const QImage* getOriginalImage() {return mOriginalImage.get();}

  void setModifiedImage( const QImage* newImage );
  const QImage* getModifiedImage() {return mModifiedImage.get();}

private:
  void setDisplayImage( const QImage* newImage );

  std::unique_ptr<QImage> mDisplayImage;
  std::unique_ptr<QImage> mOriginalImage;
  std::unique_ptr<QImage> mModifiedImage;


};


