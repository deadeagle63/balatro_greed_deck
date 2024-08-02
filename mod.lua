--- STEAMODDED HEADER
--- MOD_NAME: Greed Deck
--- MOD_ID: greed_deck
--- MOD_AUTHOR: [deadeagle63]
--- MOD_DESCRIPTION: Modded seal example
--- LOADER_VERSION_GEQ: 1.0.0
----------------------------------------------
------------MOD CODE -------------------------
GREED = {
    config = {}
}

function SMODS.INIT.greed_deck()
    load(NFS.read(SMODS.current_mod.path .. '/lib/shared.lua'))()
    load(NFS.read(SMODS.current_mod.path .. '/lib/greed_deck.lua'))()
    load(NFS.read(SMODS.current_mod.path .. '/lib/greed_joker.lua'))()
    load(NFS.read(SMODS.current_mod.path .. '/lib/greed_challenge.lua'))()


end

local ease_dollars_ref = ease_dollars
local start_run_ref = Game.start_run
local blind_debuff_card = Blind.debuff_card
function ease_dollars(mod,intent)
    local t = ease_dollars_ref(mod,intent)
    -- if using a GREED DECK RECALC
    if G.GAME.selected_back.name == "Greed Deck" then
        GREED.evaluate(G.GAME.dollars+mod,G.GAME.selected_back.effect.config.greed)
    end

    return t
end
function Game:start_run(args)
    local t = start_run_ref(self,args)
    if G.GAME.selected_back.name == "Greed Deck" then
        GREED.evaluate(G.GAME.dollars,G.GAME.selected_back.effect.config.greed)
    end
    return t
end
function Blind:debuff_card(card, from_blind)
    local t = blind_debuff_card(self, card,from_blind)
    if card.ability.set == 'Joker' then
        if card.greed_debuffed and not card.debuff then
            print('re-debuffing ')
            card:set_debuff(true)
        end
        end
    return t
end
----------------------------------------------
------------MOD CODE END----------------------