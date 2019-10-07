#pragma once

#include <QObject>
#include <QSettings>
#include "topicmetadata.hpp"
#include "constants.hpp"

struct TopicsMetaDataSort {
  inline bool operator()( const QObject* lhsObject, const QObject* rhsObject )
  {
    const TopicMetaData* lhs = static_cast<const TopicMetaData*>( lhsObject );
    const TopicMetaData* rhs = static_cast<const TopicMetaData*>( rhsObject );

    if ( lhs->orderByIndex() == rhs->orderByIndex() ) {
      return lhs->title() < rhs->title();
    } else {
      return lhs->orderByIndex() < rhs->orderByIndex();
    }
  }
};

class TopicsMetaDataBuilder final : public QObject
{
  Q_OBJECT
public:
  explicit TopicsMetaDataBuilder( QObject* parent = nullptr )
    : QObject( parent )
  {
    build();
    load();
  }

  ~TopicsMetaDataBuilder() { qDeleteAll( mTopicsMetaData ); }

  const QList<QObject*>& topicsMetaData() const { return mTopicsMetaData; }

  void load()
  {
//    QSettings settings;
//    settings.beginGroup( Constants::TopicsMetaDataTitle );

//    for ( auto item : mTopicsMetaData ) {
//      TopicMetaData* topic = static_cast<TopicMetaData*>( item );
//      topic->setOrderByIndex( settings.value( topic->title(), 0 ).toInt() );
//    }

//    settings.endGroup();
//    std::sort( mTopicsMetaData.begin(), mTopicsMetaData.end(), TopicsMetaDataSort() );
  }

  void store( const QStringList& data )
  {
//    QSettings settings;
//    settings.beginGroup( Constants::TopicsMetaDataTitle );
//    int index = 0;

//    for ( const auto& item : data ) {
//      settings.setValue( item, index++ );
//    }

//    settings.endGroup();
//    load();
  }

signals:

public slots:

private:
  void build()
  {
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Clouds,
      Constants::CloudsTitle,
      "qrc:/view/images/clouds.png",
      "qrc:/view/qml/Clouds.qml",
      "Clouds Help...."} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Lines,
      Constants::LinesTitle,
      "qrc:/view/images/lines.png",
      "qrc:/view/qml/OrbitTrap.qml",
      "Lines Help ..."} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::OrbitTraps,
      Constants::OrbitTrapTitle,
      "qrc:/view/images/orbit-trap.png",
      "qrc:/view/qml/OrbitTrap.qml",
      "Orbit Trap Help"} );

  }

  QList<QObject*> mTopicsMetaData;
};
