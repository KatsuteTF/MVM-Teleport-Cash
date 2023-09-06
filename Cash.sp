/*
    Copyright (C) 2023 Katsute

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

#pragma semicolon 1

#include <sdkhooks>
#include <sourcemod>
#include <tf2>
#include <tf2_stocks>

public Plugin myinfo = {
    name        = "MVM Teleport Cash",
    author      = "Katsute",
    description = "Automatically teleport cash to the nearest player",
    version     = "1.0",
    url         = "https://github.com/KatsuteTF/MVM-Teleport-Cash"
}

public void OnEntityCreated(int entity, const char[] classname){
    if(strncmp(classname, "item_currencypack_", 18) == 0)
        SDKHook(entity, SDKHook_SpawnPost, MoneyCreated);
}

public Action MoneyCreated(int entity){
    for(int i = 1; i <= MaxClients; i++){
        if(IsClientInGame(i) && IsPlayerAlive(i) && TFTeam:GetClientTeam(i) == TFTeam_Red && !IsFakeClient(i)){
            float origin[3];
            GetClientAbsOrigin(i, origin);
            TeleportEntity(entity, origin, NULL_VECTOR, NULL_VECTOR);
            break;
        }
    }
    return Plugin_Handled;
}