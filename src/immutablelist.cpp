﻿#include "immutablelist.hpp"
#include <QDebug>
ImmutableList::ImmutableList()
{

}

QStringList ImmutableList::symmetryGroups()
{
  if ( mSymmetryGroups.empty() ) {

    mSymmetryGroups.append( "CM (*x)" ) ;
    mSymmetryGroups.append( "CMM (2*22)" );
    mSymmetryGroups.append( "P1 (o)" );
    mSymmetryGroups.append( "P2 (2222)" );
    mSymmetryGroups.append( "P3 (333)" );
    mSymmetryGroups.append( "P31M (3*3)" );
    mSymmetryGroups.append( "P3M1 (*333)" );
    mSymmetryGroups.append( "P4 (442)" );
    mSymmetryGroups.append( "P4G (4*2)" );
    mSymmetryGroups.append( "P4M (*442)" );
    mSymmetryGroups.append( "P6 (632)" );
    mSymmetryGroups.append( "P6M (*632)" );
    mSymmetryGroups.append( "PG (xx)" );
    mSymmetryGroups.append( "PGG (22x)" );
    mSymmetryGroups.append( "PM (**)" );
    mSymmetryGroups.append( "PMG (22*)" );
    mSymmetryGroups.append( "PMM (*2222)" );
  }

  return mSymmetryGroups;
}

const QStringList& ImmutableList::flipTypes()
{
  if ( mFlipTypes.isEmpty() ) {
    mFlipTypes.append( "All" );
    mFlipTypes.append( "Alternating" );
    mFlipTypes.append( "Random" );
  }

  return mFlipTypes;
}

const QStringList& ImmutableList::projectionTypes()
{
  if ( mProjectionTypes.isEmpty() ) {
    mProjectionTypes.append( "Poincare" );
    mProjectionTypes.append( "Klein" );
  }

  return mProjectionTypes;
}

const QStringList& ImmutableList::walkFillTypes()
{
  if ( mWalkFillTypes.empty() ) {
    mWalkFillTypes.append( "Area" );
    mWalkFillTypes.append( "Length" );
  }

  return mWalkFillTypes;
}