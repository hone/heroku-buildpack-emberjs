# heroku-buildpack-emberjs
**NOTE**: This buildpack is an experimental OSS project demonstrating [Ember.js on Heroku](https://www.heroku.com/emberjs).

## Intro

This is a [Heroku Buildpack](http://devcenter.heroku.com/articles/buildpacks) for [Ember.js](http://emberjs.com/) and [ember-cli-fastboot](https://github.com/tildeio/ember-cli-fastboot) applications.

## Usage

This buildpack has a binary component, so it needs to be compiled beforehand. It's easier just to use the buildpack with the prebuilt binary.

```
$ heroku buildpacks:set https://github.com/heroku/heroku-buildpack-emberjs.git
```

Once the buildpack is set, you can `git push heroku master` like any other Heroku application.

### EmberJS

Deploying a standard ember.js app on Heroku is simple. You can run the following commands to get started.

```
$ heroku create
$ heroku buildpacks:set https://github.com/heroku/heroku-buildpack-emberjs.git
$ git push heroku master
$ heroku open
```

### Fastboot

Deploying an ember fastboot on Heroku is just as simple. You can run the following commands to get started.

```
$ heroku create
$ heroku buildpacks:set https://github.com/heroku/heroku-buildpack-emberjs.git
$ git push heroku master
$ heroku open
```

## Architecture

The buildpack is built on top of three other buildpacks, to deliver a great Ember experience.

* [heroku-buildpack-nodejs](https://github.com/heroku/heroku-buildpack-nodejs)
* [heroku-buildpack-ember-cli-deploy](https://github.com/heroku/heroku-buildpack-ember-cli-deploy)
* [heroku-buildpack-static](https://github.com/heroku/heroku-buildpack-static)

With the Node.js buildpack, you can rely on Heroku's [first class support](https://www.heroku.com/nodejs) for `node` and `npm`. This allows the buildpack to install and setup the [`ember-cli` toolchain](http://ember-cli.com/) as well as run the [ember-fastboot-server](https://github.com/ember-fastboot/ember-fastboot-server) as if it was any other Node.js application on the platform.

The ember-cli-deploy buildpack requires the ember app to be using `ember-cli`. In addition, you can customize your build on Heroku by using the [ember-cli-deploy](https://ember-cli-deploy.github.io/ember-cli-deploy) build pipeline. Fastboot is supported out of the box. The buildpack will build the assets, install any fastboot dependencies, and setup a default web process type to get you going quickly.

When not using fastboot, the static buildpack uses nginx to efficiently serve static assets while also handling HTML5 pushState, proxying, and other [common frontend hosting configurations](https://github.com/heroku/heroku-buildpack-static#configuration).

## Contributing

The buildpack builds a CLI tool generically named, `buildpack` built on top of [mruby-cli](https://github.com/hone/mruby-cli). It resides in the `buildpack/` directory. `buildpack` is a CLI binary that has 3 subcommands that correspond to the [Buildpack API](https://devcenter.heroku.com/articles/buildpack-api):

* `detect`
* `compile`
* `release`

### Running Tests

First, you'll need the [mruby-cli prerequisites](https://github.com/hone/mruby-cli#prerequisites) setup. Once inside the `buildpack/` directory:

```
$ docker-compose run mtest && docker-compose run bintest
```
