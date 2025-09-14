--The Seventh Sea
SMODS.Atlas{
    key = 'TheSeventhSea',
    path = 'TheSeventhSea.png',
    px = 71,
    py = 95
}
SMODS.Joker{
       key = 'TheSeventhSea', --joker key
    loc_txt = { -- local text
        name = 'The Seventh Sea',
        text = {
          'Each played {C:attention}7{}',
          'gives {X:mult,C:white}X#1#{} Mult'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'TheSeventhSea', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = {
      extra = {
        Xmult = 1.5 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        if args.type == 'derek_loves_you' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() == 7) then
                return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
                }
            end
        end
    end
}

--The Seventh Sky
SMODS.Atlas{
    key = 'TheSeventhSky',
    path = 'TheSeventhSky.png',
    px = 71,
    py = 95
}
SMODS.Joker{
       key = 'TheSeventhSky', --joker key
    loc_txt = { -- local text
        name = 'The Seventh Sky',
        text = {
          'Gains {X:chips,C:white}X#2#{} Chips',
          'per each played {C:attention}7{}',
          '{C:inactive}(Currently{} {X:chips,C:white}X#1# {C:inactive} Chips){}'
        },
    },
    atlas = 'TheSeventhSky', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = {
      extra = {
        xchips = 1, Xchip_mod = 0.1 --configurable value
      }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.Xchip_mod } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() == 7) then
                card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.Xchip_mod
                return {
                    message = localize { type = 'variable', key = 'a_xchips', vars = { card.ability.extra.xchips } }
                }
            end
        end

        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end

    end
}

--Love?
SMODS.Atlas{
    key = 'Love?',
    path = 'Love.png',
    px = 71,
    py = 95
}
SMODS.Joker{
       key = 'Love?', --joker key
    loc_txt = { -- local text
        name = 'Love?',
        text = {
          'This joker gains {C:mult}+2{} Mult',
          'per each played card with',
          '{C:hearts}Heart{} suit.',
          'Gains {C:mult}-4{} Mult in {C:green}#3# in #4#{} chance',
          'after scoring',
          '{C:inactive}(Currently{} {C:mult}+#2#{} {C:inactive}Mult){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Love?', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 2, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { extra =  { Mult = 0, Mult_mod = 2, mult_reduce = 4, odds = 2, suit = 'Hearts' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Mult_mod, card.ability.extra.Mult, G.GAME.probabilities.normal, card.ability.extra.odds, localize(card.ability.extra.suit, 'suits_singular') } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(card.ability.extra.suit) and not context.blueprint then
                card.ability.extra.Mult = card.ability.extra.Mult + card.ability.extra.Mult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    message_card = card
                }
            end
        end

        if context.after then
            if SMODS.pseudorandom_probability(card, 'Love?', 1, card.ability.extra.odds) then
                card.ability.extra.Mult = card.ability.extra.Mult - card.ability.extra.mult_reduce
                return {
                    message = 'Reduced',
                    colour = G.C.MULT,
                    message_card = card
                }
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.Mult
            }
        end
    end
}

--Revolver
SMODS.Atlas{
    key = 'Revolver',
    path = 'Revolver.png',
    px = 71,
    py = 95
}
SMODS.Joker{
       key = 'Revolver', --joker key
    loc_txt = { -- local text
        name = 'Revolver',
        text = {
          'This joker gains',
          '{X:mult,C:white}X1{} Mult{} every time',
          'a Blind is selected',
          '{C:inactive}(Currently{} {X:mult,C:white}X#2#{} {C:inactive}Mult){}',
          'resets to {X:mult,C:white}X1{} Mult in {C:green}#3# in #4#{} chance',
          'at end of round'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Revolver', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = {
      extra = {
        Xmult = 1, Xmult_mod = 1, mod_probability = 1, odds = 6
      }
    },
      loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult, G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,

    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint then
           card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
           return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
            }
        end

        if context.end_of_round and context.game_over == false then
            if SMODS.pseudorandom_probability(card, 'Revolver', 1, card.ability.extra.odds) then
                card.ability.extra.Xmult = 1
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
                }
            end
        end

        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}


--Crooked Penny
SMODS.Atlas{
    key = 'Crooked Penny',
    path = 'Crooked Penny.png',
    px = 71,
    py = 95
}

SMODS.Joker{
       key = 'Crooked Penny', --joker key
    loc_txt = { -- local text
        name = 'Crooked Penny',
        text = {
          'Reduces all {C:attention}listed{}',
          '{C:green,E:1}probabilities{}',
          '{C:inactive}(ex:{} {C:green}1 in 3{} {C:inactive}->{} {C:green}0.5 in 3{}{C:inactive}){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Crooked Penny', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 3, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
        loc_vars = function(self, info_queue, card)
        return { vars = { number_format(10000) } }
    end,
        calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator * 0.5
            }
        end
    end
}
