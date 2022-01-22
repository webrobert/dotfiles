#!/bin/sh

echo "Cloning repositories..."

SITES=$HOME/Development/Websites

# Personal
git clone git@github.com:driesvints/driesvints.com.git $SITES/driesvints.com
git clone git@github.com:driesvints/learn-laravel-cashier.com.git $SITES/learn-laravel-cashier.com
