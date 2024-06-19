#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 Amilcar do Carmo Lucas <amilcar.lucas@iav.de>
#
# SPDX-License-Identifier: GPL-3.0-or-later

REQUIRED_PKGS=("coverage" "mock")

is_installed() {
    pip show "$1" > /dev/null 2>&1
}

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! is_installed "$pkg"; then
        echo "Installing $pkg..."
        pip install "$pkg"
    else
        echo "$pkg is already installed."
    fi
done

PYTHONPATH=../MethodicConfigurator python -m coverage run -m unittest param_pid_adjustment_update_test.py
python -m coverage html
firefox htmlcov/param_pid_adjustment_update_py.html