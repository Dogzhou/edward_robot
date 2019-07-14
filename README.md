Edward Robot
==============

### About

This project is an Elixir solution for the classic code exercise: [toy robot simulator](problem.md)

### Custodian

Edward Zhou(edwardzhou1990@gmail.com)


### Install

if Elixir 1.18.1 has been installed on your local

```shell
$ mix deps.get
```

or

``` shell
$ docker build -t edward_robot .
```

### Usage

open iex on local or in docker

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

### TODO
Update tabletop module name
update request test description
