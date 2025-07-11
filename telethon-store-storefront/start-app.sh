#!/bin/bash
# Install yarn compatibility layer globally
chmod +x ./yarn
export PATH="$(pwd):$PATH"
echo "PATH updated to include yarn compatibility layer"

# Start the application
npm start
