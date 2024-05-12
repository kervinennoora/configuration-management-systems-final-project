#!/usr/bin/bash

# tarkista onko cowsay jo asennettu
if ! command -v cowsay &> /dev/null
then
    echo "Cowsay ei ole asennettu"
    # ensiksi päivitykset
    sudo apt update
    # toiseksi asennus
    sudo apt install cowsay
    echo "Asennus onnistui"
else
    echo "Cowsay on asennettu"
fi
