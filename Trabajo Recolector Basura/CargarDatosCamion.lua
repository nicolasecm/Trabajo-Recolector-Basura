local ValorPorParada = nil
local ValorPorFin = nil

function InicioResourceVG()
if source ~= getResourceRootElement() then return end
Archivo = xmlLoadFile ( "config.xml", true) 
if Archivo then
		local XmlValorParada = xmlFindChild(Archivo,"ValorPorParada",0)
		local XmlValorFinal = xmlFindChild(Archivo,"ValorPorFin",0)
		ValorPorParada = xmlNodeGetValue (XmlValorParada)
		ValorPorFin = xmlNodeGetValue (XmlValorFinal)
		xmlUnloadFile(Archivo)
else
	outputChatBox ( "Error al cargar los datos de config.xml" )
end
end
addEventHandler ( "onClientResourceStart", root, InicioResourceVG )

addEvent( "SolicitarDatosXmlBasura", true)
addEventHandler( "SolicitarDatosXmlBasura", getRootElement(), 
function ()
	triggerEvent("CargarValoresBas",getLocalPlayer(),ValorPorParada,ValorPorFin)
end)