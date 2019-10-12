#include "listsbuilder.hpp"

ListsBuilder::ListsBuilder()
{

}

const QStringList& ListsBuilder::symGroups()
{
  if ( mSymGroups.empty() ) {
    mSymGroups.append( "CM (*x)" ) ;
    mSymGroups.append( "CMM (2*22)" );
    mSymGroups.append( "P1 (o)" );
    mSymGroups.append( "P2 (2222)" );
    mSymGroups.append( "P3 (333)" );
    mSymGroups.append( "P31M (3*3)" );
    mSymGroups.append( "P3M1 (*333)" );
    mSymGroups.append( "P4 (442)" );
    mSymGroups.append( "P4G (4*2)" );
    mSymGroups.append( "P4M (*442)" );
    mSymGroups.append( "P6 (632)" );
    mSymGroups.append( "P6M (*632)" );
    mSymGroups.append( "PG (xx)" );
    mSymGroups.append( "PGG (22x)" );
    mSymGroups.append( "PM (**)" );
    mSymGroups.append( "PMG (22*)" );
    mSymGroups.append( "PMM (*2222)" );
  }

  return mSymGroups;
}
