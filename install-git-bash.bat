@echo off & REM avoid printing commands to console

REM install git-bash
winget install --id Git.Git -e --source winget

REM confirm git installed successfully
git --version