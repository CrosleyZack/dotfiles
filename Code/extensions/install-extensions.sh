#!/bin/bash

cat vscode-extensions.list | xargs -L 1 code --install-extension
