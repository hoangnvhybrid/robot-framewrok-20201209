#!/bin/bash
sudo apt install python-pip
pip --version
pip install virtualenv
virtualenv venv
virtualenv -p python3.8.5 venv
source venv/bin/activate