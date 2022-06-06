local i10n = _G.Wishlist.i10n

local defaultLocale = "enGB";

i10n.locales = {}

-- search for the locale, if it's not localized, return default
function i10n.SetLocale(locale)
    if (not i10n.locales[locale]) then
        i10n.actualLocale = defaultLocale;
    else 
        i10n.actualLocale = locale;
    end
end

function i10n.GetText(key)
    if (i10n.locales[i10n.actualLocale][key]) then
        return i10n.locales[i10n.actualLocale][key]
    else 
        return key
    end
end
