import os
import faiss
from sentence_transformers import SentenceTransformer

class Retriever:
    def __init__(self):
        self.model = SentenceTransformer('all-MiniLM-L6-v2')
        self.index = None
        self.documents = []
        self.embeddings = []

    def load_documents(self, directory):
        for filename in os.listdir(directory):
            if filename.endswith(".txt") or filename.endswith(".md") or filename.endswith(".json"):
                filepath = os.path.join(directory, filename)
                with open(filepath, 'r', encoding='utf-8') as f:
                    self.documents.append(f.read())
        self.embeddings = self.model.encode(self.documents)
        self.index = faiss.IndexFlatL2(self.embeddings.shape[1])
        self.index.add(self.embeddings)

    def retrieve(self, query, top_k=3):
        query_embedding = self.model.encode([query])
        D, I = self.index.search(query_embedding, top_k)
        return [self.documents[i] for i in I[0]]
