// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from "https://deno.land/std/http/server.ts"

class AIProcessor {

  async process(system_prompt: string | null, user_prompt: string | null, image_base_64: string | null, return_as_json: boolean = false): Promise<any> {

  const response = await fetch("https://router.huggingface.co/v1/chat/completions", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${Deno.env.get("HF_API_KEY")}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      model: "Qwen/Qwen3-VL-8B-Instruct:novita",
      messages: [
        ...(system_prompt ? [{role: "system", content: system_prompt}] : []),
        {
          role: "user",
          content: [
            ...(user_prompt ? [{ type: "text", text: user_prompt }] : []),
            ...(image_base_64 ? [{ type: "image_url", image_url: {url: `data:image/jpeg;base64,${image_base_64}`}}] : [])
          ]
        }
      ]
    })
  })

    const raw: any = await response.json()

    console.log(raw)
    if (!response.ok) {

      throw new Error(`HF API error: ${response.status}`)
    }

    const textOutput = raw.choices?.[0]?.message?.content

    if (!textOutput) {
      throw new Error("No content returned from model")
    }

    if(return_as_json) {
      // Safely extract JSON from the string
      const jsonStart = textOutput.indexOf("{")
      const jsonEnd = textOutput.lastIndexOf("}")

      if (jsonStart === -1 || jsonEnd === -1) {
        throw new Error("JSON not found in model output")
      }

      const jsonString = textOutput.substring(jsonStart, jsonEnd + 1)

      try {
        return JSON.stringify(JSON.parse(jsonString))
      } catch (e) {
        throw new Error("Failed to parse JSON from model output: " + e)
      }
    } else {
      // Just return the output text
      return textOutput
    }
  }
}

serve(async (req) => {

  const {
      system_prompt = null,
      user_prompt = null,
      image_base_64 = null,
      return_as_json = false
  } = await req.json()

  const processor = new AIProcessor()

  try {
    const result = await processor.process(system_prompt, user_prompt, image_base_64, return_as_json)
    return new Response(result, { status: 200 })
  } catch (e) {
    return new Response(
      JSON.stringify({
        error:  e instanceof Error ? e.message : String(e)
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
