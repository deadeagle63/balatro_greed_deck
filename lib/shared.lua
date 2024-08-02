GREED.config.greed = {
    chips = {
        money_required = 1.0,
        gained = 5.0
    },
    joker = {
        money_required = 30.0,
        gained = 1
    },
    mult = {
        money_required = 1.0,
        gained = 0.1
    }
}

GREED.config.starting_deck = {
    dollars = -4,
    joker_slot = -5
}

GREED.tracker = {
    starting_jokers = 0,
    disabled_jokers = 0,
    last_seen_dollars = 0
}
GREED.cache = {
    mult = 0,
    chips = 0,
    jokers = 0,
    prev_calc_joker = 0
}
GREED.translation = {
    "Gain {C:blue}+#1# Chips{} per {C:money}$#2#{},",
    "Gain {C:red}+#3# Mult{} per {C:money}$#4#{}",
    "and unlock {C:attention}+#5# Joker Slot{} per {C:money}$#6#{}",
    "Falling below the threshold will start disabling random jokers"
}
function GREED.evaluate(dollars, config)
    -- always execute to disable new jokers each play
    GREED.evaluate_joker_slots(dollars, config)
    if dollars == GREED.tracker.last_seen_dollars then
        return GREED.cache.chips, GREED.cache.mult
    end
    GREED.tracker.last_seen_dollars = dollars
    return GREED.evaluate_chips_and_mult(dollars, config)
end
function GREED.evaluate_chips_and_mult(dollars, config)
    -- get amount e.g $10 .. $1 money_required = 10
    local chip_count = dollars / config.chips.money_required
    local mult_count = dollars / config.mult.money_required
    -- calculate the final value e.g chip_count 10 .. gained 5 = 50
    local chips = chip_count * config.chips.gained
    local mult = mult_count * config.mult.gained

    GREED.cache.chips = chips
    GREED.cache.mult = mult

    return chips, mult;
end
local clear_current_disabled_jokers = function()
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].greed_debuffed then
            G.jokers.cards[i].greed_debuffed = false
            G.jokers.cards[i]:set_debuff(false)
        end
    end
end
local disable_active_jokers = function(jokers_based_on_dollar)
    local current_jokers = #G.jokers.cards;

    if current_jokers <= jokers_based_on_dollar then
        print("Threshold to disable not met!")
        return
    end
    -- 4 jokers, start disabling at 4 so result is +1
    local amount_to_disable = (current_jokers - jokers_based_on_dollar)

    -- don't care to keep result, keeping to Balatro RNG theme here.. add caching if you want to only disable the same jokers
    GREED.tracker.disabled_jokers = amount_to_disable
    for i=1, #G.jokers.cards do
        local joker = G.jokers.cards[i]
        if not joker.ability.name == "Greed Personified" then
            amount_to_disable = amount_to_disable - 1
        end
    end

    if amount_to_disable <= 0 then
        return
    end

    clear_current_disabled_jokers()
    while amount_to_disable > 0 do
        local idx = math.random(1, current_jokers)
        local joker = G.jokers.cards[idx]

        if joker.ability.name ~= "Greed Personified" and not joker.greed_debuffed then
            joker.greed_debuffed = true
            joker:set_debuff(true)
            amount_to_disable = amount_to_disable - 1
        end
    end
end

local evaluate_joker_activation = function()
    if GREED.tracker.disabled_jokers == 0 then
        return
    end
    GREED.tracker.disabled_jokers = 0

    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].greed_debuffed then
            G.jokers.cards[i]:set_debuff(false)
            G.jokers.cards[i].greed_debuffed = false
        end
    end
    GREED.tracker.disabled_jokers = 0
end

function GREED.evaluate_joker_slots(dollars, config)
    local joker_count = math.floor(dollars / config.joker.money_required)
    if G.GAME.challenge == 'c_greed_p4n1fyd' then
        joker_count = joker_count + 1
    end
    if not G or not G.jokers then
        print("EARLY TERMINATE")
        return
    end
    if GREED.cache.jokers == 0 and G.jokers.config.card_limit > 0 then
        -- safety for loading saves
        GREED.cache.jokers = G.jokers.config.card_limit
    end
    if joker_count == GREED.cache.prev_calc_joker then
        return
    end
    GREED.cache.prev_calc_joker = joker_count
    if joker_count >= GREED.cache.jokers then
        local to_add = joker_count - GREED.cache.jokers
        print(G.GAME.selected_back.name)
        GREED.cache.jokers = joker_count
        G.jokers.config.card_limit = G.jokers.config.card_limit + to_add
        print("TO ADD"..joker_count.." "..to_add)
        evaluate_joker_activation()
    elseif joker_count < GREED.cache.jokers then
        disable_active_jokers(joker_count)
    end
end
