# Telethon Store - Production Deployment Guide

This repository contains a production-ready Medusa e-commerce setup with a Next.js storefront, configured to work with Digital Ocean managed databases.

## Architecture

- **Backend**: Medusa.js (Node.js/TypeScript)
- **Frontend**: Next.js 15 storefront 
- **Database**: Digital Ocean PostgreSQL
- **Cache/Session Store**: Digital Ocean Valkey (Redis-compatible)
- **Reverse Proxy**: Nginx
- **Containerization**: Docker & Docker Compose

## Prerequisites

- Docker and Docker Compose installed
- Digital Ocean PostgreSQL database
- Digital Ocean Valkey (Redis) database
- SSL certificates for production domains
- Domain names configured

## Quick Start

1. **Clone and setup**:
   ```bash
   git clone <your-repo>
   cd telethon-store-dev
   ```

2. **Configure environment variables**:
   ```bash
   cp .env.production.example .env.production
   # Edit .env.production with your actual values
   ```

3. **Deploy**:
   ```bash
   # Linux/Mac
   chmod +x deploy.sh
   ./deploy.sh

   # Windows PowerShell
   .\deploy.ps1
   ```

## Configuration

### Database Configuration

Your Digital Ocean databases are already configured:

- **PostgreSQL**: `medusa-db-do-user-3370563-0.e.db.ondigitalocean.com:25060`
- **Valkey/Redis**: `telethon-valkey-do-user-3370563-0.i.db.ondigitalocean.com:25061`

The SSL certificate is located at `telethon-store/certs/ca-certificate.crt`.

### Environment Variables

Critical environment variables to update in `.env.production`:

```bash
# Security - MUST be changed for production
JWT_SECRET=your-super-secure-jwt-secret-here-change-this-in-production
COOKIE_SECRET=your-super-secure-cookie-secret-here-change-this-in-production

# Domains - Update to match your actual domains
STORE_CORS=https://your-storefront-domain.com,https://your-admin-domain.com
ADMIN_CORS=https://your-admin-domain.com
AUTH_CORS=https://your-admin-domain.com,https://your-storefront-domain.com
NEXT_PUBLIC_BASE_URL=https://your-storefront-domain.com
```

## SSL/TLS Configuration

1. **Obtain SSL certificates** for your domains
2. **Place certificates** in `nginx/ssl/` directory:
   - `fullchain.pem` (certificate + intermediate)
   - `privkey.pem` (private key)
3. **Update nginx configuration** in `nginx/nginx.conf`:
   - Replace `your-domain.com` with your actual storefront domain
   - Replace `your-api.domain.com` with your actual API domain

## Services

### Backend (Medusa)
- **Port**: 9000
- **Health Check**: `/health`
- **Admin Panel**: `/app`
- **API**: `/store`, `/admin`

### Frontend (Next.js)
- **Port**: 8000
- **Health Check**: `/health`

### Nginx Reverse Proxy
- **HTTP Port**: 80 (redirects to HTTPS)
- **HTTPS Port**: 443

## Deployment Commands

### Build and Deploy
```bash
# Build images
docker-compose build

# Deploy with migrations
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Database Operations
```bash
# Run migrations
docker-compose run --rm migration

# Seed database (development only)
docker-compose exec medusa-backend npm run seed
```

### Maintenance
```bash
# View service status
docker-compose ps

# Restart specific service
docker-compose restart medusa-backend

# Update and redeploy
git pull
docker-compose build --no-cache
docker-compose up -d
```

## Security Features

- **Rate limiting** on API endpoints
- **Security headers** (HSTS, CSP, etc.)
- **SSL/TLS encryption** with modern cipher suites
- **CORS configuration** for cross-origin requests
- **Non-root user** in Docker containers
- **Health checks** for all services

## Monitoring

### Health Checks
- **Storefront**: `https://your-domain.com/health`
- **Backend**: `https://your-api.domain.com/health`

### Logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f medusa-backend
docker-compose logs -f storefront
docker-compose logs -f nginx
```

## Troubleshooting

### Common Issues

1. **Database connection failed**:
   - Check database credentials in `.env.production`
   - Verify SSL certificate path
   - Ensure firewall allows connections

2. **Redis connection failed**:
   - Verify Redis URL format
   - Check TLS configuration

3. **Services not healthy**:
   - Check logs: `docker-compose logs`
   - Verify port availability
   - Check firewall settings

### Debug Commands
```bash
# Test database connection
docker-compose exec medusa-backend npx medusa db:migrate

# Check Redis connection
docker-compose exec medusa-backend node -e "
const redis = require('redis');
const client = redis.createClient(process.env.REDIS_URL);
client.ping().then(() => console.log('Redis connected'));
"

# Verify SSL certificates
openssl x509 -in nginx/ssl/fullchain.pem -text -noout
```

## Performance Optimization

- **Nginx** handles static assets and SSL termination
- **Redis** caching for sessions and application cache
- **PostgreSQL** optimized for production workloads
- **Docker** multi-stage builds for smaller images
- **Gzip compression** enabled
- **Connection pooling** configured

## Backup Strategy

1. **Database backups**: Use Digital Ocean automated backups
2. **Application backups**: Regular snapshots of application state
3. **SSL certificates**: Keep secure backups of certificates

## Support

For issues related to:
- **Medusa**: Check [Medusa documentation](https://docs.medusajs.com/)
- **Next.js**: Check [Next.js documentation](https://nextjs.org/docs)
- **Docker**: Check [Docker documentation](https://docs.docker.com/)
- **Digital Ocean**: Check [Digital Ocean documentation](https://docs.digitalocean.com/)

## Production Checklist

Before going live:

- [ ] Update all environment variables
- [ ] Generate secure JWT and cookie secrets
- [ ] Configure SSL certificates
- [ ] Update domain names in nginx config
- [ ] Test all services are healthy
- [ ] Configure DNS records
- [ ] Set up monitoring and alerting
- [ ] Configure automated backups
- [ ] Review security settings
- [ ] Load test the application
