# [boj-solvedac](https://rubygems.org/gems/boj-solvedac)

[![Gem Version](https://badge.fury.io/rb/boj-solvedac.svg)](https://badge.fury.io/rb/boj-solvedac)
[![Ruby](https://img.shields.io/badge/Ruby-2.7.0-red)](#) 

Baekjoon Online Judge [Solved.ac](https://solved.ac/) CLI.

## Installation
```
$ gem install boj-solvedac
```

You need to have `curl` [installed](https://curl.haxx.se/) in your machine.

**Windows**: see installation [here](http://www.confusedbycode.com/curl/#downloads)

**MacOSX**
```sh
brew install curl
```

**Arch**:
```sh
$ sudo pacman -S curl
```

**Debian**:
```sh
$ sudo apt install curl
```

## How to

### Getting the data
The program will first look for `stats/` directory to fetch levels and problems data from 
[solved.ac](https://solved.ac/). But to avoid requesting it to the web for every person 
using this gem, I first crawled necessary data and uploaded to my github. 

So, simply run the below code and it will `curl` from my [repository](https://github.com/jioneeu/boj-solvedac/tree/master/lib/data) and retrieve necessary data from there.

```rb
require 'boj-solvedac'

boj = BOJ::BOJSolvedAC.new
boj.start
```

This process will be skipped automatically if you already have `stats/` directory.

### Add solved problems data
Create a file `stats/solved-problems.dat` and copy-and-paste your solved problem(푼 문제) 
from [Baekjoon Online Judge](https://www.acmicpc.net).

### Commands

These are levels you can specify for the command:
-	unrated
-	bronze[5-1] <--- bronze5, bronze4, ..., bronze1
-	silver[5-1]
-	gold[5-1]
-	platinum[5-1]
-	diamond[5-1]
-	ruby[5-1]

`exit`, `quit`: terminates the program

`clear`: clears the screen

prob
- `prob [LEVEL]`: display all [LEVEL] problems
- `prob solved` : display all solved problems by ID

stat
- `stat [LEVEL]`: display [LEVEL]'s unsolved/solved/total stats
- `stat all`    : display all level's unsolved/solved/total stats

random
- `random`        : randomly pick a problem from all levels
- `random [LEVEL]`: randomly pick a problem from [LEVEL]  
\*Once you ran this command, simply hit [ENTER] to repeat the previous random command
