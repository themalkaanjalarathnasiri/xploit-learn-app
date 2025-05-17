from retriever import Retriever
from prompt_builder import build_prompt
from gemini_api import query_gemini

retriever = Retriever()
retriever.load_documents("documents")  # Path to your knowledge base

while True:
    question = input("Ask your vulnerability question: ")
    if question.lower() in ['exit', 'quit']:
        break
    context = retriever.retrieve(question)
    prompt = build_prompt(context, question)
    response = query_gemini(prompt)
    print("\n🤖 Gemini RAG Agent:\n", response, "\n")
