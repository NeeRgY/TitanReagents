local _, ns = ...
local L = ns.L
if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

L["LOADING"] = "Cargando..."
L["SHOW_SPELL_ICON"] = "Mostrar icono de hechizo"
L["AUTOBUY_1"] = "Comprar 1 pila"
L["AUTOBUY_2"] = "Comprar 2 pilas"
L["AUTOBUY_3"] = "Comprar 3 pilas"
L["AUTOBUY_4"] = "Comprar 4 pilas"
L["AUTOBUY_5"] = "Comprar 5 pilas"
L["AUTOBUY_CUSTOM"] = "Cantidad personalizada..."
L["CUSTOM_STACKS_PROMPT"] = "Introduce la cantidad mínima que quieres tener siempre.\nSolo se compra la diferencia si tienes menos - no esta cantidad cada vez:"
L["AUTOBUY_NONE"] = "No comprar automáticamente"
