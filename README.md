# Road to ECS

> Entity-Component-System pattern example code for PICO-8.

I'm teaching myself the [Entity-Component-System](https://en.wikipedia.org/wiki/Entity_component_system) (ECS) pattern for game development with [PICO-8](https://www.lexaloffle.com/pico-8.php). This repository contains my learning project cartridges and example code. You can read more from my ["Road to ECS"](https://www.lexaloffle.com/bbs/?tid=39315) blog thread @ Lexaloffle BBS.

## Getting Started

### Prerequisites

- [PICO-8](https://www.lexaloffle.com/pico-8.php)

### Installation

Start up PICO-8. Load and run the `.p8` cartridges.

```pico-8
cd road-to-ecs
load ecs_01_draw.p8
run
```

<img src="https://user-images.githubusercontent.com/2697454/92259791-07d97c00-eee0-11ea-9043-7825f7c2b5a8.gif" width="256" height="256" alt="installation">

## Example Cartridges

Just look in the files, there's a lot of comments.

### `ecs_topdown1.p8`

My first ECS based cartridge was MBoffin's [Top-Down Adventure Game Tutorial](https://www.lexaloffle.com/bbs/?tid=35135) game with ECS using selfsame's [ECS library](https://www.lexaloffle.com/bbs/?tid=30039). It was too complex for learning the basics, that's why it doesn't use ECS pattern for all systems.

The cartride has a state machine (states: menu, game, gameover), selfsame's ECS lib, plenty of extras from alexr's [ECS POC 2 1.0](https://www.lexaloffle.com/bbs/?pid=68554#p) and my constants. I also did some premature optimization (never do that, that's bad. seriously.) and changed all loops to use `pairs()` instead of other iterator functions just because I read that it is faster.

### `ecs_01_draw.p8`

Now I'm starting learning the pattern from the basics: how to draw entities on screen. This time I'm doing it with KatrinaKitten's [Tiny ECS Framework](https://www.lexaloffle.com/bbs/?tid=39021). There are two entities: tables `e_player` and `e_thing`. Both have a few components. Finally there's two systems functions `s_draw()` and `s_randpos()`. Entities are created in `init()` and systems are run in `update()` and `draw()`. I also reformatted the framework code to fit my style. It does not fit on PICO screen as well any more, sorry about that :)

### `ecs_02_control.p8`

A basic game feature is controlling a player avatar on screen. The controlled entity `e_player` is the only one which has the `c_control` component. That one is required by `s_control()`. `c_control` is an empty component with no data except name. Basically it's just a key or a flag to match `s_control()` requirements.

### `ecs_03_map.p8`

Draw a map and do map cell based movement. Only the player is an entity, map is not. There's also a shortcut `e_player` to avoid looping through `ents` just to search for the player. `pos` component represents map coordinates. MBoffin's Top-down-game tutorial inspired the map and camera functionality.

### `ecs_04_collision`

Collision detection between entities. Collision detection is not a "system", just a function call in movement system. Current version loops through all entities in `ents` for every move. Collision check function credit: [mboffin.itch.io/pico8-overlap](https://mboffin.itch.io/pico8-overlap).

## Other Files

### `tinyecs-1.1.lua`

[KatrinaKitten's Tiny ECS Framework v1.1](https://www.lexaloffle.com/bbs/?tid=39021) implementation, added in carts with `#include`.

## Roadmap

I'm planning to have a go with more basic game features like the following:

- Map collision detection
  - Components: c_position, c_velocity, c_collisionbox ?
- Interaction
- Turn based
- ...

## Resources

- KatrinaKitten/Lexaloffle BBS: [Tiny ECS Framework v1.1](https://www.lexaloffle.com/bbs/?tid=39021)
  - Compact ECS framework.
- selfsame/Lexaloffle BBS: [Entity Component System](https://www.lexaloffle.com/bbs/?tid=30039)
  - ECS framework.
- alexr/Lexaloffle BBS: [ECS POC 1 v. 0.5](https://www.lexaloffle.com/bbs/?pid=68554#p)
  - Utilities and extensions for selfsame's ECS.
- Klutzershy/gamedev.net: [Understanding Component-Entity-Systems](https://www.gamedev.net/tutorials/_/technical/game-programming/understanding-component-entity-systems-r3013/)
- adam/T-machine.org: [Designing Bomberman with an Entity System: Which Components?](http://t-machine.org/index.php/2013/05/30/designing-bomberman-with-an-entity-system-which-components/)
  - About design and principles.
- [Entity Systems Wiki](http://entity-systems.wikidot.com/)
- Richard Lord: [Finite State Machines with Ash](https://www.richardlord.net/blog/ecs/finite-state-machines-with-ash.html)
- Owen Pellegrin: [Simple Collision Detection](http://www.owenpellegrin.com/articles/vb-net/simple-collision-detection/)

## Notes and Learnings

- Do systems first, components will follow.
- OOP leads to too tight coupling.
- Components are 1) only data, 2) as small as possible and 3) never share data (normalized).
- Entities are only containers for components.
- Systems are logic: manipulate component data.
- FSM does not work with ECS. States are implemented by changing entity's components: the state of an entity is encapsulated in its components.
  - FSM: "define a component (one for every state machine) in which we store an integer value that represents our state"
  - `c_movement_state = cmp("movement_state", { movement_state })`
  - `c_action_state = cmp("action_state", { action_state})`
- Map tiles are not entities.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

Distributed under the [MIT](https://choosealicense.com/licenses/mit/) License. See `LICENSE` for details.

## Acknowledgments

This repository is made possible and builds on the work of the following talented people and projects:

- KatrinaKitten @ Lexaloffle BBS
- selfsame @ Lexaloffle BBS
- alexr @ Lexaloffle BBS
- [PurpleBooth/README-Template.md](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
- [Make a README](https://www.makeareadme.com/)

## Contact

- GitHub repository: [apa64/road-to-ecs](https://github.com/apa64/road-to-ecs)
- Mastodon: [@apa64@mementomori.social](https://mementomori.social/@apa64)
- Lexaloffle BBS [@apa64](https://www.lexaloffle.com/bbs/?uid=45600)
