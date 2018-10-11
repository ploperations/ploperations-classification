
# classification

The classification module is used internally at Puppet to do two key things:

- create facts based on a node's host and domain name
- verify that the facts provided during a puppet run match the values parsed from the node's cert

This helps prevent attacks via fact overrides.

_Note_: Incorrect facts can still be associated with a node, since facts are
sent before compilation.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with classification](#setup)
    * [What classification affects](#what-classification-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with classification](#beginning-with-classification)
3. [Usage](#usage)
4. [Reference](#reference)

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

This module is documented via `puppet strings generate --format markdown`.
Please see [REFERENCE.md](REFERENCE.md) for more info.
