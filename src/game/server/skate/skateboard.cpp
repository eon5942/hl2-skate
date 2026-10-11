// skateboard.cpp - physics skateboard entity
//===========================================================================//
#include "cbase.h"
#include "skateboard.h"
#include "in_buttons.h"

LINK_ENTITY_TO_CLASS( prop_skateboard, CSkateboard );

BEGIN_DATADESC( CSkateboard )
END_DATADESC()

// Placeholder: a flat wooden panel. Swap for a real skateboard .mdl later.
#define SKATEBOARD_MODEL "models/props_junk/wood_panel001a.mdl"

CSkateboard::CSkateboard()
{
}

void CSkateboard::Precache()
{
	BaseClass::Precache();
	PrecacheModel( SKATEBOARD_MODEL );
}

void CSkateboard::Spawn()
{
	BaseClass::Spawn();

	SetModel( SKATEBOARD_MODEL );
	SetSolid( SOLID_VPHYSICS );
	SetMoveType( MOVETYPE_VPHYSICS );
	SetCollisionGroup( COLLISION_GROUP_WEAPON );

	// Make it a real physics object (it falls, can be stood on).
	VPhysicsInitNormal( SOLID_VPHYSICS, 0, false );

	// TODO: riding, tricks, grinds.
}

// Console: spawn a skateboard under the local player.
CON_COMMAND( skate_spawn, "Spawn a skateboard" )
{
	CBasePlayer *pPlayer = UTIL_GetCommandClient();
	if ( !pPlayer )
		return;

	CBaseEntity *pBoard = CreateEntityByName( "prop_skateboard" );
	if ( pBoard )
	{
		Vector origin = pPlayer->GetAbsOrigin();
		origin.z += 8.0f;
		pBoard->SetAbsOrigin( origin );
		DispatchSpawn( pBoard );
	}
}
