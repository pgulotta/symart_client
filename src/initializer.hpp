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
  explicit Initializer( QObject* parent = nullptr );


private:
  void initSettings();
  void initQml();

private:
  FrontController mFrontController;
  TopicsMetaDataBuilder mTopicsMetaDataBuilder;
  QQmlApplicationEngine mQmlApplicationEngine;
  ImmutableList mImmutableList;





};


