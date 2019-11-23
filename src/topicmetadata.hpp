#pragma once

#include <QObject>


class TopicMetaData  : public QObject
{
  Q_OBJECT
  Q_ENUMS( Topic )
  Q_PROPERTY( int orderByIndex READ orderByIndex CONSTANT )
  Q_PROPERTY( int typeId READ typeId CONSTANT )
  Q_PROPERTY( QString title READ title CONSTANT )
  Q_PROPERTY( QString imageSource READ imageSource CONSTANT  )
  Q_PROPERTY( QString pageSource READ pageSource CONSTANT  )
  Q_PROPERTY( QString helpText READ helpText CONSTANT  )


signals:


public slots:


  void setOrderByIndex( int orderByIndex )
  {
    if ( m_orderByIndex == orderByIndex ) {
      return;
    }

    m_orderByIndex = orderByIndex;
  }

public:
  enum class Topic {
    Clouds,
    Clusters,
    HyperClouds,
    HyperLines,
    Info,
    Lines,
    OrbitTraps,
    QuasiOrbitTraps,
    QuasiStripes,
    Squiggles,
    Stripes,
    Walk
  };

  explicit TopicMetaData( QObject* parent = nullptr ) : QObject( parent ) {}

  TopicMetaData( TopicMetaData::Topic typeId, const QString& title, const QString& imageSource,
                 const QString& pageSource, const QString& helpText,  QObject* parent = nullptr ) :
    QObject( parent ),
    m_typeId{static_cast<int>( typeId )},
    m_orderByIndex{m_typeId},
    m_title{title},
    m_imageSource{imageSource},
    m_pageSource{pageSource},
    m_helpText{helpText}
  {}

  QString title() const
  {
    return m_title;
  }

  QString imageSource() const
  {
    return m_imageSource;
  }

  QString pageSource() const
  {
    return m_pageSource;
  }

  QString helpText() const
  {
    return m_helpText;
  }

  int orderByIndex() const
  {
    return m_orderByIndex;
  }

  int typeId() const
  {
    return m_typeId;
  }

private:
  int m_typeId{0};
  int m_orderByIndex{0};
  QString m_title;
  QString m_imageSource;
  QString m_pageSource;
  QString m_helpText;


};


