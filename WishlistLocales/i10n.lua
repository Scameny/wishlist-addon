local i10n = {}
_G.i10n = i10n;
local defaultLocale = "enGB";

i10n.locales = {}


-- search for the locale, if it's not localized, return default
function i10n.GetLocalization(locale)
    local toRet = i10n.locales[locale];
    print("Game locale pressent? ", toRet);
    if (not toRet) then
        return i10n.locales[defaultLocale];
    end
    return toRet;
end
