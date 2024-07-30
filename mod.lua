--- STEAMODDED HEADER
--- MOD_NAME: Greed Deck
--- MOD_ID: GreedDeck
--- MOD_AUTHOR: [deadeagle63]
--- PREFIX: deck
--- MOD_DESCRIPTION: Modded seal example

----------------------------------------------
------------MOD CODE -------------------------
GREED = {}
require "shared"
require "greed_deck"
require "greed_joker"

local ease_dollars_ref = ease_dollars

function ease_dollars(mod,intent)
    local t = ease_dollars_ref(mod,intent)
    return t
end
----------------------------------------------
------------MOD CODE END----------------------