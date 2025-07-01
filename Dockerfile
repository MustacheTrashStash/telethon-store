FROM node:latest

WORKDIR /app/medusa

# Copy only package files first for caching
COPY package.json yarn.lock ./

# Install system dependencies needed by Medusa (e.g. python)
RUN apt-get update && apt-get install -y python3 python3-pip python-is-python3

# Install node dependencies (including Medusa CLI)
RUN yarn install

# Now copy the rest of the project files
COPY . .

# Build the project
RUN yarn build

# Run migrations and start the server with local CLI
CMD npx medusa migrations run && npx medusa start