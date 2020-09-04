pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- ecs_02_control v. 1.1
-- by @apa64
-- with tinyecs 1.1 by @katrinakitten https://www.lexaloffle.com/bbs/?tid=39021
-- control entity

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
  e += c_draw(1)
  e += c_control()
  return e
end

-- creates a funny thing entity.
function mk_thing(x, y)
  local e = ent()
  e += c_pos(x, y)
  e += c_draw(2)
  return e
end

-->8
-- ################## components

-- x,y position
c_pos = function(x, y)
  return cmp("pos",
    { x = x, y = y })
end

-- has drawable
c_draw = function(sprite)
  return cmp("draw",
    { sprite = sprite })
end

-- controllable sprite
c_control = function()
  return cmp("control")
end

-->8
-- ##################### systems

-- drawing system
s_draw = sys({"pos", "draw"},
function(e)
  spr(e.draw.sprite, e.pos.x, e.pos.y)
end)

-- control system.
s_control = sys({"control", "pos"},
function(e)
  local sprite_size = 8 -- todo: this info should be in a component
  if (btn(0)) then
    e.pos.x -= 1
    if (e.pos.x < 0) e.pos.x = 0
  end
  if (btn(1)) then
    e.pos.x += 1
    if (e.pos.x > 127 - sprite_size) e.pos.x = 127 - sprite_size
  end
  if (btn(2)) then
    e.pos.y -= 1
    if (e.pos.y < 0) e.pos.y = 0
  end
  if (btn(3)) then
    e.pos.y += 1
    if (e.pos.y > 127 - sprite_size) e.pos.y = 127 - sprite_size
  end
end)

__gfx__
00000000000000008a68860000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000aa0008aaa680000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000aa0009999a60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000a88a009779a80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000a88a009798a60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000a22a009779a80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000a8228a09999a60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000a8228a09bbbb80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
