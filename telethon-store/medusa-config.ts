import { loadEnv, defineConfig } from '@medusajs/framework/utils'

loadEnv(process.env.NODE_ENV || 'development', process.cwd())

// Debug logging
console.log('=== Database Configuration Debug ===')
console.log('DATABASE_URL:', process.env.DATABASE_URL)
console.log('DB_HOST:', process.env.DB_HOST)
console.log('DB_PORT:', process.env.DB_PORT)
console.log('DB_USER:', process.env.DB_USER)
console.log('DB_PASSWORD:', process.env.DB_PASSWORD ? '[REDACTED]' : 'undefined')
console.log('DB_NAME:', process.env.DB_NAME)

// Construct database URL from individual components or use direct URL
const databaseUrl = process.env.DATABASE_URL || 
  (process.env.DB_HOST && process.env.DB_USER && process.env.DB_PASSWORD && process.env.DB_NAME 
    ? `postgresql://${process.env.DB_USER}:${process.env.DB_PASSWORD}@${process.env.DB_HOST}:${process.env.DB_PORT || 5432}/${process.env.DB_NAME}?sslmode=require`
    : undefined)

console.log('Final databaseUrl:', databaseUrl ? '[REDACTED URL]' : 'undefined')
console.log('=====================================')

module.exports = defineConfig({
  projectConfig: {
    databaseUrl: databaseUrl,
    http: {
      storeCors: process.env.STORE_CORS!,
      adminCors: process.env.ADMIN_CORS!,
      authCors: process.env.AUTH_CORS!,
      jwtSecret: process.env.JWT_SECRET || "supersecret",
      cookieSecret: process.env.COOKIE_SECRET || "supersecret",
    }
  }
})
