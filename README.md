# 🐱‍👤 FURIA Fan Experience App

Aplicativo Flutter desenvolvido como proposta para o desafio **"Experiência Conversacional FURIA"**, focado em simular uma **live com chat da torcida** e um **chatbot com inteligência artificial** inspirado no time de CS:GO da FURIA.

---

## 📱 Funcionalidades

### 🎮 Simulação de Live + Chat da Torcida
- Player de vídeo com partidas da FURIA (YouTube integrado)
- Chat ao estilo Twitch, com interação em tempo real

### 🤖 Chatbot FURIA com IA (GPT-4o)
- Assistente virtual personalizado representando o time
- IA responde perguntas sobre o time, história, jogos e curiosidades
- Capacidade de ler arquivos PDF usando a OpenAI Assistants API com `file_search`

---

## 🧱 Tecnologias Utilizadas

| Tecnologia          | Uso                                      |
|---------------------|-------------------------------------------|
| Flutter             | Framework principal                      |
| Provider            | Gerenciamento de estado                  |
| youtube_player_flutter | Player de vídeo embutido              |
| dash_chat_custom    | Chat customizável para torcida e IA      |
| chat_gpt_sdk (OpenAI)| Integração com GPT-4o e Assistants API  |

---

## 🔒 Chave da OpenAI

> **Atenção:**  
> A chave da OpenAI **não está incluída no repositório** por questões de segurança.

Para testar o bot:
1. Crie sua chave no [OpenAI](https://platform.openai.com/account/api-keys)
2. Adicione em `lib/shared/constants/consts.dart`:

```dart
const OPENAI_API_KEY = 'sua-chave-aqui';
