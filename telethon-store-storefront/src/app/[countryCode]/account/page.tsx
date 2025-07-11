import { Metadata } from "next"
import { notFound } from "next/navigation"

export const metadata: Metadata = {
  title: "Account Not Available",
  description: "Account functionality is not available. Please proceed with guest checkout.",
}

export default function AccountPage() {
  // Redirect to 404 since accounts are disabled
  notFound()
}
