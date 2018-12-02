Boliche

Boliche is the portuguese word for bowling, this project is an API for a bowling game.

### Documentation

This API allows you:
 * Create player: Usually when you start a bowling game, you type your and your partners name in order to identify them;
 * Create game: After creating the player you can start a game using this endpoint, basically it starts a new game creating frames and all structure needed;
 * Create shot: In order to get the score after all frames you have to input data, through this action you can send how many pins the player knocked down.
 * Show game: To get information like score, current player, frames score and so on.

#### Create player
POST http://localhost:3000/players

Request body:
```json
{
	"name": "Inigo Montoya"
}
```

Response:
201 Created
```json
{
    "data": {
        "id": 11,
        "name": "Inigo Montoya"
    }
}
```

#### Create game:
POST http://localhost:3000/games

Request body:
```json
{
  "game" : { "players" : [1] }
}
```

Response:
201 Created | 422 Precondition Failed
{
    "data": {
        "id": 30,
        "players": [
            {
                "id": 1,
                "name": "Inigo Montoya"
            }
        ]
    }
}

### Create Shot
POST http://localhost:3000/games/30/shot

Request body:
```json
{
  "game" : { "knocked_down_pins" : 9 }
}
```

Response:
201 Created

```json
{
    "data": {
        "id": 30,
        "frame_number": 0,
        "current_player": "Inigo Montoya",
        "players": [
            {
                "id": 1,
                "name": "Inigo Montoya"

... Basically the show route
```

### Show game
GET http://localhost:3000/games/30

Request body: empty

Response:
```json

{
    "data": {
        "id": 29,
        "frame_number": 3,
        "current_player": "Player number 1",
        "players": [
            {
                "id": 1,
                "name": "Player number 1"
            }
        ],
        "frames": [
            {
                "score": 30,
                "player": "Player number 1",
                "number": 0,
                "status": "strike",
                "shots": [
                    {
                        "knocked_down_pins": 10
                    }
                ]
            },
            {
                "score": 20,
                "player": "Player number 1",
                "number": 1,
                "status": "strike",
                "shots": [
                    {
                        "knocked_down_pins": 10
                    }
                ]
            },
            {
                "score": null,
                "player": "Player number 1",
                "number": 2,
                "status": "strike",
                "shots": [
                    {
                        "knocked_down_pins": 10
                    }
                ]
            },
            {
                "score": null,
                "player": "Player number 1",
                "number": 3,
                "status": "pending",
                "shots": [
                    {
                        "knocked_down_pins": 1
                    },
                    {
                        "knocked_down_pins": 9
                    },
                    {
                        "knocked_down_pins": 9
                    },
                    {
                        "knocked_down_pins": 9
                    }
                ]
            },
            {
                "score": null,
                "player": "Player number 1",
                "number": 4,
                "status": "pending",
                "shots": []
            },
            {
                "score": null,
                "player": "Player number 1",
                "number": 5,
                "status": "pending",
                "shots": []
            },
            {
                "score": null,
                "player": "Player number 1",
                "number": 6,
                "status": "pending",
                "shots": []
            },
            {
                "score": null,
                "player": "Player number 1",
                "number": 7,
                "status": "pending",
                "shots": []
            },
            {
                "score": null,
                "player": "Player number 1",
                "number": 8,
                "status": "pending",
                "shots": []
            },
            {
                "score": null,
                "player": "Player number 1",
                "number": 9,
                "status": "pending",
                "shots": []
            }
        ],
        "scores": [
            {
                "player": "Player number 1",
                "score": 50
            }
        ]
    }
}
```

### Dependencies
* Ruby (2.5.0)
* Rails (5.2.1)
* Postgres (>=9.6)

### Running the application

``` sh
gem install bundler
bundle install
bundle exec rake db:create db:migrate
bundle exec rails s
```

## Maintainers
[Gabriel Malaquias](mailto:gabriel07malakias@gmail.com)
