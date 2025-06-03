#!/bin/bash
cd /home/kavia/workspace/code-generation/tictactoe-duel-44167-4ddf3f42/tic_tac_toe_duel
npx eslint 
$ESLINT_EXIT_CODE
npm run build
BUILD_EXIT_CODE=$?
if [ $ESLINT_EXIT_CODE -ne 0 ] || [ $BUILD_EXIT_CODE -ne 0 ]; then
   exit 1
fi

