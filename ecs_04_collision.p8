pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- ecs_04_collision v. 0.1
-- by @apa64
-- with tinyecs 1.1 by @katrinakitten https://www.lexaloffle.com/bbs/?tid=39021
-- entity collision detection

--[[ MIT License

copyright (c) 2020 antti ollilainen

permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "software"), to deal
in the software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the software, and to permit persons to whom the software is
furnished to do so, subject to the following conditions:

the above copyright notice and this permission notice shall be included in all
copies or substantial portions of the software.

the software is provided "as is", without warranty of any kind, express or
implied, including but not limited to the warranties of merchantability,
fitness for a particular purpose and noninfringement. in no event shall the
authors or copyright holders be liable for any claim, damages or other
liability, whether in an action of contract, tort or otherwise, arising from,
out of or in connection with the software or the use or other dealings in the
software.
--]]
#include tinyecs-1.1.lua

-- master container of entities
ents = {}

function _init()
  -- create entities
  local e_player = mk_player(59, 119)
  local e_thing = mk_thing(30, 30)
  -- store ents in master table
  add(ents, e_player)
  add(ents, e_thing)
end

function _update()
  -- run systems
  s_control(ents)
end

function _draw()
  cls(5)
  -- run draw system
  s_draw(ents)
end

-->8
-- #################### entities

-- creates player entity.
function mk_player(x, y)
  local e = ent()
  e += c_pos(x, y)
  e += c_appearance(1, 6, 7)
  e += c_control()
  return e
end

-- creates a funny thing entity.
function mk_thing(x, y)
  local e = ent()
  e += c_pos(x, y)
  e += c_appearance(2, 6, 8)
  return e
end

-->8
-- ################## components

-- x,y position
c_pos = function(x, y)
  return cmp("pos",
    { x = x, y = y })
end

-- has drawable with size
c_appearance = function(sprite, w, h)
  w = w or 8
  h = h or 8
  return cmp("appearance",
    { sprite = sprite,
      w = w,
      h = h })
end

-- controllable tag
c_control = function()
  return cmp("control")
end

-->8
-- ##################### systems

-- drawing system
s_draw = sys({"pos", "appearance"},
function(e)
  spr(e.appearance.sprite, e.pos.x, e.pos.y)
end)

-- control system.
s_control = sys({"control", "pos", "appearance"},
function(e)
  local newx = e.pos.x
  local newy = e.pos.y
  local can_move_x = true
  local can_move_y = true
  if (btn(0)) newx -= 1
  if (btn(1)) newx += 1
  if (btn(2)) newy -= 1
  if (btn(3)) newy += 1

  -- check collision for
  -- x and y separately to
  -- "slide" along edges
  if (is_entity_collision(e, newx, e.pos.y)) can_move_x = false
  if (is_entity_collision(e, e.pos.x, newy)) can_move_y = false

  -- move, within world borders
  if (can_move_x) e.pos.x = mid(0, newx, 127 - e.appearance.w + 1)
  if (can_move_y) e.pos.y = mid(0, newy, 127 - e.appearance.h + 1)
end)

-->8
-- ##################### helpers

function is_entity_collision(e, newx, newy)
  -- note: performance problem
  -- when there's a lot of e's
  -- b/c we iterate all twice on
  -- every update
  for e2 in all(ents) do
    if (e != e2 and e2.appearance and overlap(e, newx, newy, e2)) return true
  end
  return false
end

-- detect if box a and b overlap
-- original: https://mboffin.itch.io/pico8-overlap
function overlap(a, newx, newy, b)
  return not (newx >= b.pos.x + b.appearance.w
           or newy >= b.pos.y + b.appearance.h
           or newx + a.appearance.w <= b.pos.x
           or newy + a.appearance.h <= b.pos.y)
end

__gfx__
0000000000aa00008a68860000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000aa00008aaa680000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000a88a0009999a60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000a88a0009779a80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000a22a0009798a60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700a8228a009779a80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000a8228a009999a60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000009bbbb80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
