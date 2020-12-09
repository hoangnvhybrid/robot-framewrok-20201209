#!/bin/bash
robot --version
rebot --version
python -m robot.run -d result -v ENV:local -L trace testcases