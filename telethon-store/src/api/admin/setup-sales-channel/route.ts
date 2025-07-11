import { MedusaRequest, MedusaResponse } from "@medusajs/framework/http"

export async function POST(
  req: MedusaRequest,
  res: MedusaResponse
) {
  try {
    const query = req.scope.resolve("query")
    
    // Check if a sales channel already exists
    const { data: existingChannels } = await query.graph({
      entity: "sales_channel",
      fields: ["id", "name", "is_default"],
    })
    
    res.json({
      message: "Sales channel check completed",
      sales_channels: existingChannels,
      count: existingChannels.length
    })
  } catch (error) {
    res.status(500).json({
      message: "Error checking sales channels",
      error: error.message
    })
  }
}
