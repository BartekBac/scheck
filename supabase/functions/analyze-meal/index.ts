// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from "https://deno.land/std/http/server.ts"

interface MealAIResponse {
  mealType: string
  ingredients: string[]
  description: string
}

interface VisionMealAnalyzer {
  analyzeMeal(imageBase64: string): Promise<MealAIResponse>
}

class HuggingFaceAnalyzer implements VisionMealAnalyzer {

  async analyzeMeal(imageBase64: string): Promise<MealAIResponse> {

    const prompt = `
You are a food recognition assistant.

Return ONLY raw JSON in this format:

{
  "mealType": "breakfast | lunch | dinner | snack | supper | other",
  "ingredients": string[],
  "description": string
}

No markdown.
No explanation.
`

    const response = await fetch("https://router.huggingface.co/v1/chat/completions", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${Deno.env.get("HF_API_KEY")}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        model: "Qwen/Qwen3-VL-8B-Instruct:novita",
        messages: [
          {
            role: "user",
            content: [
              { type: "text", text: prompt },
              {
                type: "image_url",
                image_url: {
                  url: `data:image/jpeg;base64,${imageBase64}`
                }
              }
            ]
          }
        ]
      })
    })

    const raw: any = await response.json()
    console.log(raw)

    if (!response.ok) {

      throw new Error(`HF API error: ${response.status}, response json: ${JSON.stringify(raw)}`)
    }

    const textOutput = raw.choices?.[0]?.message?.content

    if (!textOutput) {
      throw new Error("No content returned from model")
    }
    
    // Safely extract JSON from the string
    const jsonStart = textOutput.indexOf("{")
    const jsonEnd = textOutput.lastIndexOf("}")
    
    if (jsonStart === -1 || jsonEnd === -1) {
      throw new Error("JSON not found in model output")
    }
    
    const jsonString = textOutput.substring(jsonStart, jsonEnd + 1)
    
    try {
      return JSON.parse(jsonString)
    } catch (e) {
      throw new Error("Failed to parse JSON from model output: " + e)
    }
  }
}

serve(async (req) => {

  const { imageBase64 } = await req.json()

  const analyzer: VisionMealAnalyzer = new HuggingFaceAnalyzer()

  try {
    const result = await analyzer.analyzeMeal(imageBase64)
    return new Response(JSON.stringify(result), { status: 200 })
  } catch (e) {
    return new Response(
      JSON.stringify({
        error:  e instanceof Error ? e.message : String(e),
        message: e instanceof Error ? e.message : String(e)
      }),
      { status: 500 }
    )
  }
})

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/analyze-meal' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
