#!/bin/bash
# Force npm usage and start the frontend
echo "Starting Next.js frontend with npm..."
echo "Setting up yarn wrapper..."
chmod +x ./yarn
export PATH=".:$PATH"
npm start
