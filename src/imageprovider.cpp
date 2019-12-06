#include "imageprovider.hpp"

ImageProvider::ImageProvider():
  QQuickImageProvider( QQuickImageProvider::Image ),
  mImage{new QImage}
{
}

void ImageProvider::setImage( const QImage* newImage )
{
  mImage = std::make_unique<QImage>( *newImage  ) ;
}

QImage ImageProvider::requestImage( const QString& id, QSize* size, const QSize& requestedSize )
{
  return *mImage.get();
}

