--------BLIP----------
blipBasura = createBlip ( 2164.923828125, -1977.912109375, 12.55375289917 ,56, 1, 255, 0, 0, 255, 0, 300 )
--------MARKER----------
markertBasura= createMarker ( 2164.923828125, -1977.912109375, 12.55375289917, "cylinder",1.8, 229, 236, 17, 255 )
markervBasura = createMarker (2184.6943359375, -1992.703125, 12.546875,"cylinder",2, 229, 236, 17, 255)
local Valor1 = nil
local Valor2 = nil

function CargarValoresBas(ValPre1,ValPre2)
Valor1 = ValPre1
Valor2 = ValPre2
end
addEvent( "CargarValoresBas", true)
addEventHandler( "CargarValoresBas", getRootElement(), CargarValoresBas)

local marcadoresTrabajo= {
	[1]={2289.8916015625, -1977.302734375, 12.340699195862},
	[2]={2237.841796875, -1889.3388671875, 12.546875},
	[3]={2064.744140625, -1926.5498046875, 12.546875},
	[4]={1827.54296875, -1773.6142578125, 12.546875},
	[5]={1974.8994140625, -1756.712890625, 12.3828125},
	[6]={2153.2666015625, -1756.064453125, 12.389909744263},
	[7]={2298.0703125, -1755.087890625, 12.546875},
	[8]={2408.962890625, -1945.8642578125, 12.3828125},
	[9]={2334.625, -1968.33984375, 12.313451766968},
	[10]={2208.7861328125, -1951.005859375, 12.554578781128}
}

function crearMarcadores( variable)
    local var = variable
	local vCar = 0
	local x, y, z = marcadoresTrabajo[var][1], marcadoresTrabajo[var][2], marcadoresTrabajo[var][3]
	local carro = getPedOccupiedVehicle(getLocalPlayer())
	triggerEvent("SolicitarDatosXmlBasura",getLocalPlayer())
	marcaBa = createMarker( x, y, z, "cylinder",3, 229, 236, 17, 255 )
	bl = createBlipAttachedTo(marcaBa,36)
	addEventHandler ( "onClientPlayerVehicleExit", getRootElement(),
			function ( vehicle)
			if isElement(marcaBa)then
			destroyElement(marcaBa)
			destroyElement(bl)
			end
			end)
	addEventHandler('onClientMarkerHit', marcaBa,
	function ( hitPlayer )
    if ( getElementType ( hitPlayer ) == "player" ) and ( hitPlayer == localPlayer ) then
		if(getElementData(localPlayer, "Ocupacion" ) == "Recolector de basura") then
			triggerServerEvent ( "darPlataBasura", getLocalPlayer(), Valor1)
			destroyElement(marcaBa)
			destroyElement(bl)		
			var = var + 1
			if(var==11)then	
			finRuta()
			triggerServerEvent ( "darPlataBasura", getLocalPlayer(), Valor2)
			outputChatBox("[Basurero]#ffffffFinalizaste la ruta, has obtenido una recomenza extra, vuelve por otro Camion", 69, 117, 62,true)
			else
			setElementVelocity (getPedOccupiedVehicle(getLocalPlayer()), 0, 0, 0)
			toggleControl ( "accelerate", false )
			toggleControl ( "brake_reverse", false )
			toggleControl ( "handbrake", false )
			toggleControl ( "enter_exit", true )
			local sonido = playSound("camion.mp3",false)		
			setSoundVolume(sonido, 1) 
			setTimer (
				function ( )
				toggleControl ( "accelerate", true )
				toggleControl ( "brake_reverse", true )
				toggleControl ( "handbrake", true )
				toggleControl ( "enter_exit", true )
			end
			,3300, 1
			)
			crearMarcadores(var)
			end	
		end
    end
	end )
end

local sx,sy = guiGetScreenSize()
local px,py = 1440,900
local x,y =  (sx/px), (sy/py)

function PanelBasura()
    window = guiCreateWindow(x*456, y*212, x*520, y*452, "Trabajo Recolector de Basura", false)
    guiWindowSetSizable(window, false)

    local obtenernombreinicio = getPlayerName(getLocalPlayer())	
    memomision1 = guiCreateMemo(x*10, y*25, x*242, y*417, "" .. obtenernombreinicio ..  " a partir de ahora trabajaras como recolector de basura, tu decides si aceptar o no", false, window)
    guiMemoSetReadOnly(memomision1, true)
    botonaceptar = guiCreateButton(x*279, y*25, x*227, y*76, "Aceptar Trabajo", false, window)
    botonsalir = guiCreateButton(x*278, y*339, x*228, y*82, "Salir", false, window)
    
	showCursor(true)
	addEventHandler("onClientGUIClick", botonaceptar, empezartBasura, false)
	addEventHandler("onClientGUIClick", botonaceptar, dieHandler, false)
	addEventHandler("onClientGUIClick", botonaceptar, salir1, false)	
	addEventHandler("onClientGUIClick", botonsalir, salir1, false)
end

function dieHandler(p)
	addEventHandler ("onClientRender", getRootElement(), IniciarTrabajo)
	setTimer(function() removeEventHandler("onClientRender",getRootElement(),IniciarTrabajo) end,10000,1)
end

function finRuta(p)
	addEventHandler ("onClientRender", getRootElement(), FinalizarRuta)
	setTimer(function() removeEventHandler("onClientRender",getRootElement(),FinalizarRuta) end,10000,1)
end

function empezartBasura ()
	showCursor(false)
	triggerServerEvent ( "CambiarTeamTrabajoBasura", getLocalPlayer() ) 
	triggerServerEvent ( "CambiarOcupacionBasura", getLocalPlayer() )
end

function IniciarTrabajo ()
    dxDrawText("Trabajo iniciado", 212, 611, 820, 646, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Trabajo iniciado!", 212, 609, 820, 644, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Trabajo iniciado!", 210, 611, 818, 646, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Trabajo iniciado!", 210, 609, 818, 644, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Trabajo iniciado!", 211, 610, 819, 645, tocolor(69, 117, 62, 255),1.6, "sans", "center", "center", false, false, true, false, false)
end

function FinalizarRuta ()
    dxDrawText("Ruta Finalizada", 212, 611, 820, 646, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Ruta Finalizada!", 212, 609, 820, 644, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Ruta Finalizada!", 210, 611, 818, 646, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Ruta Finalizada!", 210, 609, 818, 644, tocolor(0, 0, 0, 255), 1.6, "sans", "center", "center", false, false, true, false, false)
    dxDrawText("Ruta Finalizada!", 211, 610, 819, 645, tocolor(69, 117, 62, 255),1.6, "sans", "center", "center", false, false, true, false, false)
end

function salir1()
	showCursor(false)
	destroyElement(window)
end

addEventHandler('onClientMarkerHit', markertBasura,
function ( hitPlayer )
    if ( getElementType ( hitPlayer ) == "player" ) and ( hitPlayer == localPlayer ) then
		if(getElementData(localPlayer, "Ocupacion" ) == "Recolector de basura") then
			outputChatBox("[Basurero]#ffffffUsted ya tiene este trabajo", 69, 117, 62,true)
			else
			if(isPedInVehicle (getLocalPlayer()))then
			outputChatBox("[Basurero]#ffffffNo puede usarlo si esta en un vehiculo", 69, 117, 62,true)
			else
				if(getElementData(localPlayer, "Ocupacion" ) == "Civil") then
				PanelBasura()
				else
					outputChatBox("[Basurero]#ffffff tienes que ser civil para tener este trabajo, usa el comando /civil", 69, 117, 62,true)
				end
			end
			
		end
    end
end )

addEventHandler('onClientMarkerHit', markervBasura,
function ( hitPlayer )
    if ( getElementType ( hitPlayer ) == "player" ) and ( hitPlayer == localPlayer ) then
		if(getElementData(localPlayer, "Ocupacion" ) == "Recolector de basura") then
			triggerServerEvent ( "CrearCarroBasura", getLocalPlayer() )
			local conta = 1
			crearMarcadores(conta)
		end
    end
end )



