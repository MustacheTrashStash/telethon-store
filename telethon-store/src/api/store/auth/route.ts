import { MedusaRequest, MedusaResponse } from "@medusajs/framework/http"

export async function POST(
  req: MedusaRequest,
  res: MedusaResponse
) {
  // Disable customer login
  res.status(403).json({
    message: "Customer login is disabled. Please proceed with guest checkout.",
    type: "not_allowed"
  })
}
