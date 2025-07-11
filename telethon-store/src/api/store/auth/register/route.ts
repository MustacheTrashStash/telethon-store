import { MedusaRequest, MedusaResponse } from "@medusajs/framework/http"

export async function POST(
  req: MedusaRequest,
  res: MedusaResponse
) {
  // Disable customer registration
  res.status(403).json({
    message: "Customer registration is disabled. Please proceed with guest checkout.",
    type: "not_allowed"
  })
}
