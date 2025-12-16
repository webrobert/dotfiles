# Dotfiles

Hi Future Robert (and other Dev's),

This repository contains my personal macOS setup and dotfiles. *[Dries blog post](https://driesvints.com/blog/getting-started-with-dotfiles) shows his orginal files with way more settings. I have deleted settings not relevant to my work.*

When getting a new Mac, I can restore my working environment quickly, predictably,
and without guessing what I used to do.

## What This Sets Up

Running the setup script will configure a macOS machine for:

- Laravel development (container-first via Docker + Lando)
- Homebrew-managed CLI tools and applications
- Zsh with minimal, intentional customization
- macOS defaults I prefer for daily work
- A single, consistent project directory: ~/Sites

Local PHP is installed only for tooling (Composer). Runtime happens in containers.

## Fresh macOS Setup

These instructions assume:
- macOS is freshly installed
- you’ve signed into your Apple ID
- this machine will be used for development


### 1. Update macOS

Install all available system updates via System Settings.

### 2. Generate or verify SSH access

If you already have an SSH key registered with GitHub, you can skip this step.

To generate a new key:

```
curl https://raw.githubusercontent.com/webrobert/dotfiles/HEAD/ssh.sh | sh -s "your@email.com"
```

After the script runs, copy the public key and add it to GitHub.


### 3. Clone this repository

```
git clone git@github.com:webrobert/dotfiles.git ~/.dotfiles
```

### 4. Run the setup

```
bash ~/.dotfiles/fresh.sh
```

This will:
- install Homebrew (if missing)
- install CLI tools and applications
- configure the shell
- apply macOS defaults
- create the ~/Sites directory
- optionally clone personal repositories

### 5. Restart your shell (or reboot)

Some changes require a new shell session or a full restart.

After that, the machine should be ready for daily work.

## Daily Usage Notes

- All projects live in ~/Sites
- Docker Desktop must be opened once after installation
- Laravel projects are run via Lando
- Helper scripts (spin-*.sh, clone.sh) are optional conveniences

This repo is meant to evolve. If something no longer reflects how I work,
it should be updated or removed.

## Inspiration & Credit

This setup was influenced by the broader dotfiles community, mainly,
- [Dries Vints](https://driesvints.com/blog/getting-started-with-dotfiles)  
- Zach Holman
- Mathias Bynens
