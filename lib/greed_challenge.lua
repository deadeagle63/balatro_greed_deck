G.localization.misc.challenge_names["c_greed_p4n1fyd"] = "Greed Personified"

table.insert(G.CHALLENGES,1,{
    name = "Greed Personified",
    id = 'c_greed_p4n1fyd',
    rules = {
        custom = {
        },
        modifiers = {
            {id = 'dollars', value = 10},
            {id = 'discards', value = 3},
            {id = 'hands', value = 4},
            {id = 'reroll_cost', value = 5},
            {id = 'joker_slots', value = 1},
            {id = 'consumable_slots', value = 5},
            {id = 'hand_size', value = 8},
        }
    },
    jokers = {
        {id = 'j_greed_p4n1fyd', eternal = true, edition = 'negative'}, -- id of jokers can be looked up in game.lua at line ~500
    },
    consumeables = {
    },
    vouchers = {
    },
    deck = {
        type = 'Challenge Deck'
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        }
    }
})