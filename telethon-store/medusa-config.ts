import { loadEnv, defineConfig } from '@medusajs/framework/utils'
import * as fs from 'fs'
import * as path from 'path'

loadEnv(process.env.NODE_ENV || 'production', process.cwd())

module.exports = defineConfig({
  projectConfig: {
    databaseUrl: process.env.DATABASE_URL,
    redisUrl: process.env.REDIS_URL,
    http: {
      storeCors: process.env.STORE_CORS!,
      adminCors: process.env.ADMIN_CORS!,
      authCors: process.env.AUTH_CORS!,
      jwtSecret: process.env.JWT_SECRET || "supersecret",
      cookieSecret: process.env.COOKIE_SECRET || "supersecret",
    },
    database: {
      ssl: {
        ca: fs.readFileSync(path.resolve(__dirname, './certs/ca-certificate.crt')).toString(),
      },
    },
  },
});