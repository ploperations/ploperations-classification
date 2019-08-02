# classification

![](https://img.shields.io/puppetforge/pdk-version/ploperations/classification.svg?style=popout)
![](https://img.shields.io/puppetforge/v/ploperations/classification.svg?style=popout)
![](https://img.shields.io/puppetforge/dt/ploperations/classification.svg?style=popout)
[![Build Status](https://travis-ci.org/ploperations/ploperations-classification.svg?branch=master)](https://travis-ci.org/ploperations/ploperations-classification)

The classification module is used internally at Puppet to do two key things:

- create facts based on a node's host and domain name
- verify that the facts provided during a puppet run match the values parsed from the node's cert

This helps prevent attacks via fact overrides.

_Note_: Incorrect facts can still be associated with a node, since facts are
sent before compilation.

- [Description](#description)
- [Setup](#setup)
  - [What classification affects](#what-classification-affects)
  - [Setup Requirements](#setup-requirements)
  - [Beginning with classification](#beginning-with-classification)
- [Usage](#usage)
- [Reference](#reference)
- [Changelog](#changelog)

## Description

Unless you have a naming convention that exactly matches what we are using this
module will not work out of the box for you. It is provided here in hopes that
the underlying ideas will be useful in your own works.

## Setup

### What classification affects

Classification is intended to be included on all nodes via `site.pp`

### Setup Requirements

Stdlib is required for this module to work.

### Beginning with classification

```puppet
include classification
```

## Usage

```puppet
facter -p classification
```

## Reference

This module is documented via
`pdk bundle exec puppet strings generate --format markdown`.
Please see [REFERENCE.md](REFERENCE.md) for more info.

## Changelog

[CHANGELOG.md](CHANGELOG.md) is generated prior to each release via
`pdk bundle exec rake changelog`. This process relies on labels that are applied
to each pull request.
