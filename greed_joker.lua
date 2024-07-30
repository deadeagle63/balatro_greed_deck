local greed_p4n1fyd = SMODS.Joker {
    name = 'Greed Personified',
    key = 'greed_p4n1fyd',
    config = {
        mult = 0,
        chips = 0,
        joker_slots = 0,
        greed = GREED.config.greed
    },
    pos = { x = 0, y = 0 },
    loc_def = {
        name = 'Greed Personified',
        text = GREED.translation
    },
    rarity = 4,
    cost = 15,
    discovered = true,
    eternal_compat = true,
    calculate = function (self, card, ctx)
        if ctx.joker_main then
            local chips, mult = GREED.evaluate_chips_and_mult(G.GAME.dollars, card.config.greed)
            GREED.evaluate_joker_slots(G.GAME.dollars, card.config.greed)

            return {
                mult =  mult,
                chips = chips
            }
        end
    end
}


GREED.joker = greed_p4n1fyd;
GREED.joker:register();