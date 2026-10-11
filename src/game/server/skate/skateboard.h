// skateboard.h - minimal skateboard entity skeleton
//===========================================================================//
#pragma once

#include "baseanimating.h"

// A physics-driven skateboard. This is the hook point for the whole mod:
// attach the player, add flick-it trick input, board rotation, grinds.
class CSkateboard : public CBaseAnimating
{
	DECLARE_CLASS( CSkateboard, CBaseAnimating );
public:
	CSkateboard();

	virtual void Spawn();
	virtual void Precache();

	// TODO: player riding state
	// void StartRiding( CBasePlayer *pPlayer );
	// void StopRiding();
	// void DoTrick( const char *trickName );

	// TODO: trick system — map flick direction -> rotation (reuse the GTA design:
	// roll=pitch flip, yaw=shove, hold=catch). Input goes here once movement works.
};
