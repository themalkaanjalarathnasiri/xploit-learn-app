def build_prompt(contexts, question):
    prompt = "Use the following information to answer the question accurately:\n\n"
    for i, ctx in enumerate(contexts):
        prompt += f"Context {i+1}:\n{ctx}\n\n"
    prompt += f"Question:\n{question}\n\nAnswer:"
    return prompt
