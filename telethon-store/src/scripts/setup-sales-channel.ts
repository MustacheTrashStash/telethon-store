import { 
  ExecArgs,
  MedusaContainer,
} from "@medusajs/framework/types"

export default async function setupSalesChannel({
  container,
}: ExecArgs): Promise<void> {
  console.log("Setting up sales channel...")
  
  try {
    const remoteQuery = container.resolve("remoteQuery")
    
    // Check if sales channel exists
    const existingChannels = await remoteQuery({
      entryPoint: "sales_channel",
      fields: ["id", "name"],
    })
    
    if (existingChannels.length === 0) {
      // Create sales channel using workflow
      const { createSalesChannelsWorkflow } = await import("@medusajs/core-flows")
      
      const workflow = createSalesChannelsWorkflow(container)
      await workflow.run({
        input: {
          salesChannelsData: [{
            name: "Web Store",
            description: "Main storefront sales channel"
          }]
        }
      })
      
      console.log("✅ Sales channel created successfully")
    } else {
      console.log("✅ Sales channel already exists")
    }
    
  } catch (error) {
    console.error("❌ Error setting up sales channel:", error)
  }
}
