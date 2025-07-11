#!/bin/bash
# Force npm usage and start the backend
echo "Starting Medusa backend with npm..."
echo "Setting up yarn wrapper..."
chmod +x ./yarn
export PATH=".:$PATH"
npm start
