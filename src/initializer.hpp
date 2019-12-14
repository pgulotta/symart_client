#pragma once

#include <QObject>
#include <QQmlApplicationEngine>
#include "topicsmetadatabuilder.hpp"
#include "immutablelist.hpp"
#include "frontcontroller.hpp"

class Initializer final : public QObject
{
public:
  Q_OBJECT

public:
  explicit Initializer( FrontController& frontController, QObject* parent = nullptr );


private:
  //void initSettings();
  void initQml( FrontController& frontController );

private:

  TopicsMetaDataBuilder mTopicsMetaDataBuilder;
  ImmutableList mImmutableList;
  QQmlApplicationEngine mQmlApplicationEngine;






};


