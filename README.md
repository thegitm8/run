# RUN
Node.js/NPM script runner written in BASH

Think of RUN as `npm run` with superpowers. Scripts is a second class citizen in npm, which is good (it's a package manager, not a script runner), but inconvenient. RUN solves this by making npm scripts first class citizens and adding more functionality and extensions to it.

> NOTE: Currently, this only works with BASH.

<!-- TOC -->

- [RUN](#run)
    - [Install](#install)
    - [Usage](#usage)
        - [Options](#options)
        - [Simple usage](#simple-usage)
        - [Second level commands](#second-level-commands)
    - [with DB](#with-db)

<!-- /TOC -->


## Install

For `run` to work you need `node`/`npm` installed on your host machine. To use `run`s database containers, you will also need `docker`.

Install with `curl`:
```
curl -o- https://raw.githubusercontent.com/thegitm8/run/master/setup.sh | bash
```

or `wget`:

```
wget -qO- https://raw.githubusercontent.com/thegitm8/run/master/setup.sh | bash
```

This will clone the `run` repo into your home directory and add `run`s bin folder to your path. Afterwards, type `source ~/.bashrc` into your terminal. Verify success by entering `run` into your bash. You should see `run`s help.

## Usage
If you run `run` in a directory with a `package.json`, it will use the scripts defined there. If no scripts are found, `run` will use it's own script (if available).

### Options
`run` provides a minimal set of options:

Name|Action
---|---
`-h/--help`|Shows help
`-d/--develop`|Sets `NODE_ENV` to "development"
`-w/--withdb`|[Start DB container](#with-db). Available: [ 'mongo', 'influx' ]

### Simple usage
given you have a script named `awesome` in your package.json scripts:

```Shell
run awesome

# or with params

run awesome -w param
```

This is the same as running `npm run awesome`, except you don't need to separate params with `--` [as you would have to do with npm](https://docs.npmjs.com/cli/run-script).

### Second level commands
I like to "group" commands which are semantically similar - like starting a server and a client - by separating verb and subject with double colons (like `start:server` and `start:client`). `run` allows you to treat those commands like subcommands by omitting the double colon:

```shell
run start server
# or
run start client
```

## with DB

I often find myself needing a quick development database for projects, but at the same time not wanting to clutter my machine with long running database instances or configuring cloud solutions, or... you name it.

`run` can start/create a container instance of a specified DB, map it's data to a local directory and close it when you're done.

To start such a container, just provide the `-w` or `--withdb` flag with your desired DB and you're done.

```
run -w mongo start
```
The databases data is locally persisted under `.db/<db_name>` so make sure to add `.db` to your `.gitignore`.
