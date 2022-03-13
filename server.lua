function CambiaarTeam()
	local team = getTeamFromName("Trabajadores")
	setPlayerTeam( source, team)
	local resp = getElementModel(source)
	setElementData  (source, "SkinF", resp)
	setElementModel(source,16)
	setPlayerNametagColor (source, 229,236,17)
end
addEvent( "CambiarTeamTrabajoBasura", true)
addEventHandler( "CambiarTeamTrabajoBasura", getRootElement(), CambiaarTeam)

function darPlataBasura (total)
	givePlayerMoney ( source, total)
end
addEvent( "darPlataBasura", true)
addEventHandler( "darPlataBasura", getRootElement(), darPlataBasura)

function CambiarOcupacionBasu()
    setElementData(source,"Ocupacion", "Recolector de basura", true)
	setElementData(source,"VehiTrabajo", 0, true)
end
addEvent( "CambiarOcupacionBasura", true)
addEventHandler( "CambiarOcupacionBasura", getRootElement(), CambiarOcupacionBasu)

function CrearCarro()
	local comprobar = getElementData(source, "VehiTrabajo")
	if (comprobar == 0) then
    vehiculoB = createVehicle ( 408, 2184.6943359375, -1992.703125, 14.546875, 0, 0, 360, "Basura" )
	warpPedIntoVehicle(source,vehiculoB)
	outputChatBox("[Basurero]#ffffffSi te sales del vehiculo este se destruira y empezaras de nuevo",source, 69, 117, 62,true)
	outputChatBox("[Basurero]#ffffffVe al signo de dinero rojo para recolectar la basura",source, 69, 117, 62,true)
	setElementData  (source, "VehiTrabajo", 1)
	else
	outputChatBox("[Basurero]#ffffffYa estas en un vehiculo",source, 69, 117, 62,true)
	end
end

addEvent( "CrearCarroBasura", true)
addEventHandler( "CrearCarroBasura", getRootElement(), CrearCarro)

function DestruirCarroBasura (vehicle)
if isElement(vehicle)then
  if ( getVehicleID ( vehicle ) == 408 ) then
    destroyElement(vehicle)
	setElementData(source,"VehiTrabajo", 0, true)
	else
  end
  end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), DestruirCarroBasura )