Edward Robot

[![CircleCI](https://circleci.com/gh/edxzh/edward_robot.svg?style=svg)](https://circleci.com/gh/edxzh/edward_robot)

### About

This project is an Elixir solution for the classic code exercise: [toy robot simulator](problem.md)

### Custodian

Edward Zhou(edwardzhou1990@gmail.com)

### Envrionment
Elixir 1.13 or Docker

### Install

if Elixir 1.13 has been installed on your local

```shell
$ mix deps.get
```

if not please use docker

``` shell
$ docker build -t edward_robot .
```

### Usage

open iex

``` shell
$ iex -S mix
```

or

``` shell
$ docker run -ti edward_robot iex -S mix
```

``` shell
iex> place 5, 5, :east
iex> move
iex> left
iex> right
iex> report
iex> move
iex> report
```

### Development

#### Testing
``` shell
$ mix test
```

#### Style check
``` shell
$ mix credo
```
