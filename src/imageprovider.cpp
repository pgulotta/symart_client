#include "imageprovider.hpp"
#include <QBuffer>

QByteArray toByteArray( const QImage& image )
{
  QByteArray ba  ;

  if ( image.sizeInBytes() > 0 ) {
    QBuffer buffer( &ba );
    buffer.open( QIODevice::WriteOnly );
    image.save( &buffer, "PNG" );
  }

  return ba ;
}

ImageProvider::ImageProvider():
  QQuickImageProvider( QQuickImageProvider::Image ),
  mDisplayImage{new QImage}, mOriginalImage{new QImage}, mModifiedImage{new QImage}
{
}

void ImageProvider::setDisplayImage( const QImage* newImage )
{
  mDisplayImage = std::make_unique<QImage>( *newImage  ) ;
}

QImage ImageProvider::requestImage( const QString& id, QSize* size, const QSize& requestedSize )
{
  Q_UNUSED( id )
  Q_UNUSED( size )
  Q_UNUSED( requestedSize )
  return *mDisplayImage.get();
}

QByteArray ImageProvider::displayImageToByteArray() const
{
  const QImage* image = getDisplayImage();

  if ( image == nullptr )
    return QByteArray{};
  else {
    return toByteArray( *image );
  }
}

void ImageProvider::setOriginalImage( const QImage* newImage )
{
  mOriginalImage = std::make_unique<QImage>( *newImage  ) ;
  setDisplayImage( newImage );
}

void ImageProvider::setModifiedImage( const QImage* newImage )
{
  mModifiedImage = std::make_unique<QImage>( *newImage  ) ;
  setDisplayImage( newImage );
}
