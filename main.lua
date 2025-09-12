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
          '{C:green}probabilities{}',
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
    check_for_unlock = function(self, args)                      -- equivalent to `unlock_condition = { type = 'chip_score', chips = 10000 }`
        return args.type == 'chip_score' and args.chips >= 10000 -- See note about Talisman on the wiki
    end,
        calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator * 0.5
            }
        end
    end
}
