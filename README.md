# Road to ECS

> Entity-Component-System pattern example code for PICO-8.

I'm teaching myself the [Entity-Component-System](https://en.wikipedia.org/wiki/Entity_component_system) (ECS) pattern for game development with [PICO-8](https://www.lexaloffle.com/pico-8.php). This repository contains my learning project cartridges or example code. You can read more from my ["Road to ECS" blog thread @ Lexaloffle BBS](https://www.lexaloffle.com/bbs/?tid=39315).

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

## Example Cartridges

Just look in the files, there's a lot of comments.

### `ecs_topdown1.p8`

My first ECS based cartridge was MBoffin's [Top-Down Adventure Game Tutorial](https://www.lexaloffle.com/bbs/?tid=35135) game with ECS using selfsame's [ECS library](https://www.lexaloffle.com/bbs/?tid=30039). It was too complex for learning the basics, that's why it doesn't use ECS pattern for all systems.

The cartride has a state machine (states: menu, game, gameover), selfsame's ECS lib, plenty of extras from alexr's [ECS POC 2 1.0](https://www.lexaloffle.com/bbs/?pid=68554#p) and my constants. I also did some premature optimization (never do that, that's bad. seriously.) and changed all loops to use `pairs()` instead of other iterator functions just because I read that it is faster.

### `ecs_01_draw.p8`

Now I'm starting learning the pattern from the basics: how to draw entities on screen. This time I'm doing it with KatrinaKitten's [Tiny ECS Framework](https://www.lexaloffle.com/bbs/?tid=39021). There are two entities: tables `e_player` and `e_thing`. Both have a few components. Finally there's two systems functions `s_draw()` and `s_randpos()`. Entities are created in `init()` and systems are run in `update()` and `draw()`. I also reformatted the framework code to fit my style. It does not fit on PICO screen as well any more, sorry about that :)

### `ecs_02_control.p8`

A basic game feature is controlling a player avatar on screen. The controlled entity `e_player` is the only one which has the `c_control` component. That one is required by `s_control()`. `c_control` is an empty component with no data except name. Basically it's just a key or a flag to match `s_control()` requirements.

### Roadmap

I'm planning to have a go with more basic game features like the following:

- Map
- Collision detection
- Interaction

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

Distributed under the [MIT](https://choosealicense.com/licenses/mit/) License. See `LICENSE` for details.

## Acknowledgments

This repository is made possible and builds on the work of the following talented people and projects:

- Lexaloffle BBS [@KatrinaKitten: Tiny ECS Framework v1.1](https://www.lexaloffle.com/bbs/?tid=39021)
- Lexaloffle BBS [@selfsame: Entity Component System](https://www.lexaloffle.com/bbs/?tid=30039)
- Lexaloffle BBS [@alexr: ECS POC 1 v. 0.5](https://www.lexaloffle.com/bbs/?pid=68554#p)
- [PurpleBooth/README-Template.md](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
- [Make a README](https://www.makeareadme.com/)

## Contact

- GitHub repository: [apa64/road-to-ecs](https://github.com/apa64/road-to-ecs)
- Twitter [@apa64](https://twitter.com/apa64)
- Lexaloffle BBS [@apa64](https://www.lexaloffle.com/bbs/?uid=45600)
