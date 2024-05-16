# ASbot - RAG Chatbot & Complaint-Suggestion System 

🤩 As part of the first Hackathon of the Hack Series sponsored by Anadolu Sigorta, we developed a chatbot that can answer users' questions quickly and effectively. This chatbot is designed to help users learn about various topics related to Anadolu Sigorta products. In addition, to further enrich the user experience, we integrated a complaint and suggestion system that can be accessed from both the application menu and the chatbot interface. This system allows users to provide direct feedback when they have any problems or suggestions. The aim of our project is to respond quickly and efficiently to users' needs and provide them with comprehensive support.


Contributors

[@kubilaygulacdi](https://github.com/kubilaygulacdi) - Data Scientist

[@aydozy](https://github.com/aydozy) - Mobile Developer

- 1st place in the competition where 146 team competed.

## Tech Stack
- **Web**: Streamlit
- **Mobile**: Dart & Flutter
- **Generative AI**: Langchain, OpenAI
- **Backend**: Python, MongoDB, ChromaDB, Flask

## ASbot - RAG Chatbot & Complaint-Suggestion System GenAI Features

**ChatOpenAI**: The ChatOpenAI class is used to create a chat assistant using OpenAI's GPT-3.5 model.

**OpenAIEmbeddings**: OpenAIEmbeddings is used to turn texts into embedded vectors (embeddings). This enables semantic analysis and comparison of texts.

**TextLoader**: `TextLoader` is used to load texts from a specific file. This provides the source texts on which the chat assistant will be based.

**RecursiveCharacterTextSplitter**: This tool breaks large texts into smaller pieces. This makes large texts easier to process and increases efficiency.

**VectorStore**: `ChromaDB` organizes text fragments into vectors and stores them in a repository. This enables fast and efficient text searches.

**RetrievalQA**: `RetrievalQA` retrieves the most relevant information from the identified texts to answer users' questions.

**query**: This function processes the questions received from the user and generates appropriate responses. PromptTemplate and RetrievalQA are used in this process.

**Template**: This is a format template that makes the Q&A system work by bringing together the user's questions and the underlying texts.

## ASbot - RAG Chatbot & Complaint-Suggestion System Mobile Features

**HTTP GET Request**:
- Sends an HTTP GET request to a given URL.
- It performs network requests using the http packet.
- It is asynchronous and waits for a response to the HTTP request.

**ChatScreen Class**:
- Manages the main chat screen of the application.
- It uses `TextEditingController` to manage user messages.
- Stores sent and received messages as a list.
- Shows a default message to the user at startup.
- Receives incoming messages from the user and retrieves their replies via API.

**ComplaintPage Class**:
- Creates a separate page for the complaint and suggestion form.
- It uses `TextEditingController` to get various information from the user.
- A DatePicker is integrated for date selection.
- Uses the submitComplaint function to send the complaint data to the API.

**WelcomeScreen Class**:
- Creates the application's welcome screen.
- It shows a background image (acting as a mockup) and contains a button to switch to the chat screen.

## ASbot UI

  <img src="https://github.com/kubilaygulacdi/Hackathon-AnadoluSigorta/assets/104395137/7db253d6-3b1b-4f0d-b676-20746047a82a" width="250" height="500">

## Complaint & Suggestion System Application Image

In our project, we remained faithful to Anadolu Sigorta's existing app designs, thus maintaining brand consistency and offering users a familiar experience. This approach aims to both strengthen brand identity and increase user satisfaction.

<img src="https://github.com/kubilaygulacdi/Hackathon-AnadoluSigorta/assets/104395137/191c020f-b26d-4a43-8e1b-b295af6e19c0" width="250" height="500">

## ASbot Demo

[![Video Önizleme](https://github.com/kubilaygulacdi/Hackathon-AnadoluSigorta/assets/104395137/your-preview-image.jpg)](https://github.com/kubilaygulacdi/Hackathon-AnadoluSigorta/assets/104395137/ac43619a-863f-4229-bbac-950aece9283f)




