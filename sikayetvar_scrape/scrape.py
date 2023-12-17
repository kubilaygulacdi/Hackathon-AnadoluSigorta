from bs4 import BeautifulSoup
import requests
import pandas as pd
from scraping import text_preprocess_viki
from collections import Counter
import seaborn as sns
import matplotlib.pyplot as plt

def get_soup(url):
    headers = {"User-Agent":
               "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"}
    response = requests.get(url, headers=headers)
    return BeautifulSoup(response.content, 'html.parser') if response.status_code == 200 else None

domain = "https://www.sikayetvar.com/anadolu-sigorta?page="

complaints = []
solved_complaints = []

for page_number in range(1, 110):
    try:
        # not solved complaints
        print(f"Processing page {page_number}...")
        soup = get_soup(domain + str(page_number))

        for complaint in soup.select(".card-v2.ga-v.ga-c"):
            title = complaint.select_one(".complaint-title a").text.strip()
            description = complaint.select_one(".complaint-description").text.strip()
            complaints.append([title, description])

        # solved complaints
        for solved_complaint in soup.select(".card-v2.solved.ga-v.ga-c"):
            title = solved_complaint.select_one(".complaint-title a").text.strip()
            description = solved_complaint.select_one(".complaint-description").text.strip()
            solved_complaints.append([title, description])
    except:
        print("hata")


complaint_df = pd.DataFrame(complaints, columns=["Title", "Description"])
solved_complaint_df = pd.DataFrame(solved_complaints, columns=["Title", "Description"])


complaint_text = "".join(text for text in complaint_df["Description"])
solved_complaint_text = "".join(text for text in solved_complaint_df["Description"])

cleaned_complaint_text = "".join(text_preprocess_viki.remove_stopwords
                                (text_preprocess_viki.remove_numbers
                                (text_preprocess_viki.remove_punctions
                                (text_preprocess_viki.lower_word(complaint_text)))))

cleaned_solved_complaint_text = "".join(text_preprocess_viki.remove_stopwords
                                (text_preprocess_viki.remove_numbers
                                (text_preprocess_viki.remove_punctions
                                (text_preprocess_viki.lower_word(solved_complaint_text)))))


complaint_df["Cleaned"] = complaint_df["Description"].apply(lambda x: text_preprocess_viki.remove_stopwords(
                                                              text_preprocess_viki.remove_numbers(
                                                              text_preprocess_viki.remove_punctions(
                                                              text_preprocess_viki.lower_word(x)))))

solved_complaint_df["Cleaned"] = solved_complaint_df["Description"].apply(lambda x: text_preprocess_viki.remove_stopwords(
                                                              text_preprocess_viki.remove_numbers(
                                                              text_preprocess_viki.remove_punctions(
                                                              text_preprocess_viki.lower_word(x)))))

# title
complaint_title_text = " ".join([i for i in complaint_df["Title"]])
solved_complaint_title_text = " ".join([i for i in solved_complaint_df["Title"]])
clean_complaint_title_text = text_preprocess_viki.remove_stopwords(text_preprocess_viki.remove_numbers(
                                                                   text_preprocess_viki.remove_punctions(
                                                                   text_preprocess_viki.lower_word(complaint_title_text))))

clean_solved_complaint_title_text = text_preprocess_viki.remove_stopwords(text_preprocess_viki.remove_numbers(
                                                                   text_preprocess_viki.remove_punctions(
                                                                   text_preprocess_viki.lower_word(solved_complaint_title_text))))

all_title_text = clean_complaint_title_text, clean_solved_complaint_title_text
all_title_text = " ".join(all_title_text)

# title words
title_words = all_title_text.split(" ")
title_trigram = [(title_words[i], title_words[i+1], title_words[i+2], title_words[i+3]) for i in range(len(title_words)-3)]
title_trigram_freq = Counter(title_trigram)
top_10_title = title_trigram_freq.most_common(10)

full_text = cleaned_complaint_text, cleaned_solved_complaint_text
full_text = " ".join(full_text)

# BOW
words = full_text.split(" ")
words_freq = Counter(words)
top_10_words = words_freq.most_common(10)

# 2-gram
bigrams = [(words[i], words[i+1]) for i in range(len(words)-1)]
bigrams_freq = Counter(bigrams)
top_10_bigrams = bigrams_freq.most_common(10)

# 3-gram

trigrams = [(words[i], words[i+1], words[i+2]) for i in range(len(words)-2)]
trigrams_freq = Counter(trigrams)
top_10_trigrams = trigrams_freq.most_common(10)

# 4-gram
fourgrams = [(words[i], words[i+1], words[i+2], words[i+3]) for i in range(len(words)-3)]
fourgrams_freq = Counter(fourgrams)
top_10_fourgrams = fourgrams_freq.most_common(10)

# to avoid repetition, create a function that show ngram graphs
def n_gram_plot(top10, n):
    n_gram = []
    n_gram_count = []

    for i in top10:
        n_gram.append(i[0])
        n_gram_count.append(i[1])
    data = {f"{n}-Gram": [row for row in n_gram], "count": [num for num in n_gram_count]}
    df_ngram = pd.DataFrame(data=data)
    df_ngram[f"{n}-Gram"] = df_ngram[f"{n}-Gram"].astype(str)

    sns.barplot(data=df_ngram, y=f"{n}-Gram", x="count")
    plt.title(f"Top 10 {n}-Grams")
    plt.show(block=True)

n_gram_plot(top_10_trigrams, n=2)



solved_complaint_df.to_csv("solved_complaints.csv", index=False)
complaint_df.to_csv("complaints.csv", index=False)
