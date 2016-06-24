#pragma once

#include <ShSDK/ShSDK.h>
#include <ShEntryPoint/ShEntryPoint.h>

#include <Plugin/Plugin.h>

void OnPreInitialize	(void);
void OnPostInitialize	(void);
void OnPreUpdate		(float dt);
void OnPostUpdate		(float dt);
void OnPreRelease		(void);
void OnPostRelease		(void);
