local greed_deck = SMODS.Back{
    name = "Greed Deck",
    key = "greedDeck",
    pos = {x=0,y=3},
    config = {
        dollars=GREED.config.starting_deck.dollars,
        joker_slot=GREED.config.starting_deck.joker_slot,
        greed = GREED.config.greed,
        },
    loc_txt = {
        name = "Greed Deck",
        text = GREED.translation
    },
    loc_vars = function(self)
        return { vars = {
            self.config.greed.chips.gained,
            self.config.greed.chips.money_required,
            self.config.greed.mult.gained,
            self.config.greed.mult.money_required,
            self.config.greed.joker.gained,
            self.config.greed.joker.money_required
        }}
    end,
    unlocked = true,
    discovered = true, 
    trigger_effect = function(self,args)
        if args.context == "final_scoring_step" then
            local chips, mult = GREED.evaluate(G.GAME.dollars, self.config.greed)
            args.chips = args.chips + chips
            args.mult = args.mult + mult

            update_hand_text({
                delay = 0
            },
            {
                mult = args.mult,
                chips = args.chips,
            })
            return args.chips, args.mult
        end
    end
}


GREED.deck = greed_deck;