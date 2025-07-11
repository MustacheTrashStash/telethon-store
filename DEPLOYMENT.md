# Telethon Store - Digital Ocean App Platform Deployment

This guide will help you deploy your Telethon Store to Digital Ocean App Platform using your GitHub repository.

## Prerequisites

✅ **Already Done:**
- Digital Ocean PostgreSQL database configured
- Digital Ocean Valkey (Redis) database configured
- SSL certificate for database connection
- GitHub repository ready

## Deployment Steps

### 1. Prepare Your Repository

Make sure your code is pushed to GitHub:

```bash
git add .
git commit -m "Production deployment setup"
git push origin main
```

### 2. Create App on Digital Ocean

1. Go to [Digital Ocean Apps](https://cloud.digitalocean.com/apps)
2. Click **"Create App"**
3. Choose **"GitHub"** as source
4. Select your repository: `telethon-store-dev`
5. Choose branch: `main`
6. **Enable "Autodeploy"** for automatic deployments on push

### 3. Configure App Settings

Digital Ocean will detect your `.do/app.yaml` file and use it for configuration.

**Important**: Update these placeholders in `.do/app.yaml`:
- Replace `your-github-username` with your actual GitHub username
- The app URLs will be auto-generated after deployment

### 4. Environment Variables

The following environment variables are already configured in `.do/app.yaml`:

**Backend Service:**
- `DATABASE_URL` - Your PostgreSQL connection
- `REDIS_URL` - Your Valkey connection  
- `JWT_SECRET` - **CHANGE THIS** to a secure value
- `COOKIE_SECRET` - **CHANGE THIS** to a secure value

**Frontend Service:**
- `NEXT_PUBLIC_MEDUSA_BACKEND_URL` - Will be auto-updated after deployment

### 5. Deploy

1. Click **"Create Resources"**
2. Digital Ocean will:
   - Build your applications
   - Run database migrations (PRE_DEPLOY job)
   - Deploy your services
   - Provide URLs for your apps

### 6. Post-Deployment Configuration

After deployment, you'll get URLs like:
- Backend: `https://telethon-store-backend-xxxxx.ondigitalocean.app`
- Frontend: `https://telethon-store-storefront-xxxxx.ondigitalocean.app`

**Update CORS Settings:**

1. Go to your app settings in Digital Ocean
2. Update the environment variables:
   - `STORE_CORS` - Add your storefront URL
   - `ADMIN_CORS` - Add your backend URL
   - `AUTH_CORS` - Add both URLs separated by comma

Or update the `.do/app.yaml` file with the actual URLs and push to GitHub.

### 7. Access Your Application

- **Storefront**: `https://telethon-store-storefront-xxxxx.ondigitalocean.app`
- **Admin Panel**: `https://telethon-store-backend-xxxxx.ondigitalocean.app/app`
- **API**: `https://telethon-store-backend-xxxxx.ondigitalocean.app`

## Configuration Details

### Database Connection
Your PostgreSQL database is automatically configured with:
- SSL/TLS encryption
- Connection pooling
- The CA certificate is included in your repository

### Redis/Valkey Connection
Your Valkey database is configured with:
- TLS encryption
- Connection pooling
- Used for caching and session storage

### Health Checks
Both services include health check endpoints:
- Backend: `/health`
- Frontend: `/health`

## Scaling and Performance

Your app is configured with:
- **Instance Size**: `basic-xxs` (can be upgraded)
- **Instance Count**: 1 (can be scaled up)
- **Auto-scaling**: Available in higher plans

## Monitoring

Digital Ocean provides:
- **Application logs**
- **Performance metrics**
- **Health monitoring**
- **Alerting** (configurable)

## Custom Domain (Optional)

To use your own domain:
1. Go to your app settings
2. Click **"Domains"**
3. Add your custom domain
4. Update DNS records as instructed
5. SSL certificates will be auto-generated

## Troubleshooting

### Common Issues:

1. **Build Failed**: Check the build logs in Digital Ocean console
2. **Database Connection**: Verify the DATABASE_URL is correct
3. **CORS Errors**: Update the CORS environment variables with correct URLs
4. **Health Check Failed**: Check the `/health` endpoints

### Useful Commands:

```bash
# Check logs
doctl apps logs <app-id>

# Restart app
doctl apps restart <app-id>

# Get app info
doctl apps get <app-id>
```

## Security Features

✅ **Automatic SSL/TLS** certificates
✅ **Database encryption** with SSL
✅ **Redis TLS** encryption
✅ **Environment variable** encryption
✅ **Network isolation**
✅ **Health monitoring**

## Cost Optimization

Your current configuration:
- **Backend**: ~$5/month (basic-xxs)
- **Frontend**: ~$5/month (basic-xxs)
- **Total**: ~$10/month (plus database costs)

## Updates and Maintenance

1. **Code Updates**: Push to GitHub, auto-deploys
2. **Database Migrations**: Run automatically on deploy
3. **Dependencies**: Update package.json and push
4. **Configuration**: Update .do/app.yaml and push

## Support

- **Digital Ocean Docs**: https://docs.digitalocean.com/products/app-platform/
- **Medusa Docs**: https://docs.medusajs.com/
- **App Platform Console**: https://cloud.digitalocean.com/apps

---

**Next Steps:**
1. Deploy your app using the steps above
2. Update the URLs in your configuration
3. Test all functionality
4. Set up monitoring and alerts
5. Configure your custom domain (optional)
