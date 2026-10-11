// skateboard.cpp - minimal skateboard entity skeleton
//===========================================================================//
#include "cbase.h"
#include "skateboard.h"

LINK_ENTITY_TO_CLASS( prop_skateboard, CSkateboard );

BEGIN_DATADESC( CSkateboard )
	// TODO: Save/restore fields (riding state, trick state).
END_DATADESC()

CSkateboard::CSkateboard()
{
}

void CSkateboard::Precache()
{
	BaseClass::Precache();

	// TODO: precache the skateboard model + sounds once we have one.
	// PrecacheModel( "models/skateboard.mdl" );
}

void CSkateboard::Spawn()
{
	BaseClass::Spawn();

	// TODO: set model, create VPhysics object (SOLID_VPHYSICS), so the board is
	// a real physical prop the player can stand on and push around.

	// TODO: this is where skateboarding begins:
	//  - player uses the board -> attach, switch MoveType
	//  - read +strafe/+forward as steering, +jump as ollie
	//  - flick input -> tricks (flip/shove), VPhysics angular impulse
	//  - grind detection via a ground-trace down from the trucks
}
