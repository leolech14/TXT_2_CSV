import docling
import json
import sys
import os

def convert(pdf_path):
    doc = docling.Document.from_file(pdf_path)
    pages = [{"page": i+1, "text": page.text} for i, page in enumerate(doc.pages)]
    json_path = pdf_path + ".json"
    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(pages, f, ensure_ascii=False, indent=2)

if __name__ == "__main__":
    for filename in os.listdir('.'):
        if filename.endswith('.pdf'):
            convert(filename)
