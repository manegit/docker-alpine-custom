import openai
import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("prompt", help="enter a question")

args = parser.parse_args()

# Set up your OpenAI API key
openai.api_key = os.environ["OPENAI_API_KEY"]

# Define your question prompt
prompt = args.prompt

# Set up the API parameters
model_engine = "gpt-3.5-turbo"
params = {
    "prompt": prompt,
    "temperature": 0.7,
    "max_tokens": 100,
    "top_p": 1,
    "frequency_penalty": 0,
    "presence_penalty": 0,
}

# Call the API to get the response
# response = openai.Completion.create(engine=model_engine, prompt=prompt, **params)

response = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[
        {"role": "user", "content": prompt},
    ],
)

# Print the answer
answer = response.choices[0].message.content.strip()
print(answer)
