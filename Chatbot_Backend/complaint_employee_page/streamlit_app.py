import streamlit as st
from pymongo import MongoClient
import pandas as pd
from PIL import Image


mongo_url = "mongodb+srv://mkgulacdi:KDumYPV2ueOXINCn@ascluster.6rdtmya.mongodb.net/?retryWrites=true&w=majority"
myclient = MongoClient(mongo_url)
db = myclient.get_database("complaint_db")

table_name = "customers"

def get_sikayetler():
    return db[table_name].find().sort("_id", -1)

img = Image.open("img3.png")

def main():
    st.set_page_config(page_title="AS Şikayet Panel", page_icon="🔵", layout="wide")
    st.image(img, width=250)
    st.title(":gray[Müşteri Şikayet Yönetim Platformu]")
    sikayetler = list(get_sikayetler())

    # Refresh butonu
    if st.button("Yenile"):

        # MongoDB'den verileri çek
        sikayetler = list(get_sikayetler())

        # Verileri bir liste haline getir
        rows = []
        for sikayet in sikayetler:
            row = {
                "id": str(sikayet["_id"]),
                "İsim": sikayet["user"]["name"],
                "Soyisim": sikayet["user"]["surname"],
                "Telefon No": sikayet["user"]["no"],
                "E-Mail": sikayet["user"]["email"],
                "Şikayet Başlığı": sikayet["user"]["title"],
                "Şikayet": sikayet["user"]["complaint"],
                "Konu": sikayet["user"]["topic"]

            }
            rows.append(row)


        df = pd.DataFrame(rows)




    rows = []
    for sikayet in sikayetler:
        row = {
            "id": str(sikayet["_id"]),
            "İsim": sikayet["user"]["name"],
            "Soyisim": sikayet["user"]["surname"],
            "Telefon No": sikayet["user"]["no"],
            "E-Mail": sikayet["user"]["email"],
            "Başlık": sikayet["user"]["title"],
            "Şikayet": sikayet["user"]["complaint"],
            "Konu": sikayet["user"]["topic"],
            "Tarih": sikayet["user"]["date"]

        }
        rows.append(row)

    df = pd.DataFrame(rows)

    st.dataframe(df)


if __name__ == "__main__":
    main()
