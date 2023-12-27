import re

def load_stopwords(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        stopwords = [line.strip() for line in file]
    return stopwords

stopwords_file_path = r'C:\Users\K\PycharmProjects\anadolu_sigorta\scraping\stop_words.txt'

tr_stopwords = load_stopwords(stopwords_file_path)

def remove_punctions(text):
    text = re.sub(r'[^\w\s]', ' ', text)  # kelime ve boşluk karakterleri dışındakileri kaldırır
    text = re.sub(r"\s+", " ", text)  # fazla boşlukları temizler
    return text.strip()
    
def remove_numbers(text):
    return re.sub(r'\d+', '', text)

def remove_stopwords(text):
    words = text.split()
    filtered_words = [w for w in words if w not in tr_stopwords]
    return " ".join(filtered_words)

def lower_word(text):
    return text.lower()

