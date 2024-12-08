# home

## What

Common user configuration that can be shared for all hosts.

## Why

As a user, I want to define my own configuration for my hosts in 2 ways:

1. Common/shared configuration for ALL hosts.
2. Specific configuration for only one host.

## Core (common config for all hosts)

File/directory: `home/<user>/common/core`

The core configuration that this user wants to share for ALL of the hosts.

Regardless of what host the user is logged in, he wants to have the exact same things.

This can include, for example: Env variables, fonts, personal git configs, shell aliases, etc.

## Host (specific config for one host)

File: `home/<user>/<host>.nix`

Where `<host>.nix` declares configuration and packages of this `<user>` for this specific host.

## Optional

Things like hyprland config, etc.

File: `home/<user>/common/optional`
