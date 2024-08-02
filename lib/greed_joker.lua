local greed_p4n1fyd = SMODS.Joker {
    name = 'Greed Personified',
    key = 'j_greed_p4n1fyd',
    config = {
        mult = 0,
        chips = 0,
        joker_slots = 0,
        greed = GREED.config.greed
    },
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Greed Personified',
        text = GREED.translation
    },
    rarity = 4,
    cost = 15,
    discovered = true,
    eternal_compat = true,
    calculate = function (self, card, ctx)
        local chips, mult = GREED.evaluate(G.GAME.dollars, self.config.greed)
        if ctx.joker_main then

            return {
                mult_mod =  mult,
                chip_mod = chips
            }
        end
    end,
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'j_greed_p4n1fyd_queue_1', vars = {GREED.cache.mult, GREED.cache.chips, GREED.cache.jokers}}

        return {vars = {
            self.config.greed.chips.gained,
            self.config.greed.chips.money_required,
            self.config.greed.mult.gained,
            self.config.greed.mult.money_required,
            self.config.greed.joker.gained,
            self.config.greed.joker.money_required
        }}
    end
}


GREED.joker = greed_p4n1fyd;
GREED.joker:register();

G.localization.descriptions.Other['j_greed_p4n1fyd'] = {
    name = 'Greed Personified',
    text = GREED.translation
}
G.localization.descriptions.Other['j_greed_p4n1fyd_queue_1'] = {
    name = 'Greed Tips With Juan',
    text = {
        '{C:red}#1# Mult',
        '{C:chips}#2# Chips',
        '{C:dark_edition}#3# Joker Slots'
    }
}

SMODS.Atlas{
    key = "jokers",
    path = "greed_joker.png",
    px = 71,
    py = 95
}