#pragma once

#include <QQuickImageProvider>
#include <memory>


class ImageProvider : public QQuickImageProvider
{
public:
  ImageProvider();
  void setImage( const QImage* newImage );
  QImage requestImage( const QString& id, QSize* size, const QSize& requestedSize ) override;

private:
  std::unique_ptr<QImage> mImage;



};


