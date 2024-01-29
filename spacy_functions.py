import spacy

# Load the Spacy model
nlp = spacy.load("en_core_web_sm")

def identify_entities(text):
    doc = nlp(text)
    entities = []
    for ent in doc.ents:
        entities.append((ent.text, ent.start_char, ent.end_char, ent.label_))
    return entities
