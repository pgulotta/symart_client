#include "imageprovider.hpp"

ImageProvider::ImageProvider():
  QQuickImageProvider( QQuickImageProvider::Image ),
  mImage{new QImage}, mOriginalImage{new QImage}, mModifiedImage{new QImage}
{
}

void ImageProvider::setImage( const QImage* newImage )
{
  mImage = std::make_unique<QImage>( *newImage  ) ;
}

QImage ImageProvider::requestImage( const QString& id, QSize* size, const QSize& requestedSize )
{
  Q_UNUSED( id )
  Q_UNUSED( size )
  Q_UNUSED( requestedSize )
  return *mImage.get();
}

void ImageProvider::setOriginalImage( const QImage* newImage )
{
  mOriginalImage = std::make_unique<QImage>( *newImage  ) ;
  setImage( newImage );
}

void ImageProvider::setModifiedImage( const QImage* newImage )
{
  mModifiedImage = std::make_unique<QImage>( *newImage  ) ;
  setImage( newImage );
}
