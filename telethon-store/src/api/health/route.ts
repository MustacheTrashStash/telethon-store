import { MedusaRequest, MedusaResponse } from "@medusajs/framework/http"

export async function GET(req: MedusaRequest, res: MedusaResponse) {
  try {
    return res.status(200).json({
      status: "ok",
      timestamp: new Date().toISOString(),
      service: "telethon-store-backend",
      version: process.env.npm_package_version || "1.0.0"
    })
  } catch (error) {
    return res.status(500).json({
      status: "error",
      timestamp: new Date().toISOString(),
      service: "telethon-store-backend",
      error: error.message
    })
  }
}
