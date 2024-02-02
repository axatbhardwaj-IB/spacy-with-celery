def identify_entities(text, use_gpu=False):
    import spacy

    if use_gpu:
        try:
            import cupy
        except ImportError:
            raise ValueError("Cannot use GPU, CuPy is not installed. Please install it in your requirements.txt")

        spacy.require_gpu()
        print("Using GPU")

    nlp = spacy.load("en_core_web_trf")
    doc = nlp(text)
    return [(ent.text, ent.label_) for ent in doc.ents]