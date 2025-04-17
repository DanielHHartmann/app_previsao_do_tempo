# 🌤️ Clean Weather

Aplicativo Flutter para exibir a previsão do tempo atual, por hora e para os próximos dias. Permite buscar por cidades, usar a localização atual e alternar entre temas claro e escuro.

---

## 📱 Capturas de Tela

### Página Principal

### Menu de Escolha de Localização

### Pesquisa por Localização

---

## ✅ Funcionalidades

- Mostra a **temperatura atual** e **condição climática** (ex.: nublado).
- Exibe a **previsão de temperatura e chuva ao longo do dia**.
- Traz a **previsão do tempo para a semana**.
- Detecta e usa a **localização atual do usuário**, com permissão.
- Permite **buscar e adicionar novas localizações** (salvas localmente no dispositivo).
- Permite **excluir localizações** salvas.
- Suporte a **tema claro e escuro** com troca dinâmica no menu lateral.
- Atualização dos dados com **gesto de arrastar para baixo** (pull-to-refresh).

---

## 🌐 API Utilizada

Este app utiliza a [Open-Meteo API](https://open-meteo.com/) — uma API gratuita que não exige chave de autenticação para consultas de previsão do tempo.

---

## 🚀 Instruções de Instalação

Você pode rodar o Clean Weather de duas formas:

---

### 🔹 **Sem compilar (instalação direta via APK)**

Se você **não quiser compilar o app**, pode instalar diretamente o arquivo `.apk` já incluso no repositório.

1. Vá até a pasta do projeto:

2. Transfira o arquivo `app-release.apk` para o seu celular (via cabo USB, e-mail, Google Drive, etc).

3. No seu Android, ative a opção:
   **Configurações > Segurança > Instalar apps desconhecidos**  
   (ou **Fontes desconhecidas**, dependendo da versão).

4. Abra o **Gerenciador de Arquivos**, toque no APK e siga os passos para concluir a instalação.

✅ Pronto! O app estará disponível como **Clean Weather**.

---

### 🔹 **Compilando o projeto (build via Flutter)**

> Recomendado se você deseja testar, modificar ou aprender com o código.

#### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dispositivo Android ou iOS conectado via USB com **Depuração USB ativada**, ou emulador.

#### Passo a Passo

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/seu-usuario/app_previsao_do_tempo.git
   ```

   Acesse a pasta do projeto:

   ```bash
   cd app_previsao_do_tempo
   ```

2. **Instale as dependências do Flutter:**

   ```bash
   flutter pub get
   ```

3. **Conecte seu celular com a depuração USB ativa ou inicie um emulador.**

4. **Execute o projeto:**

   ```bash
   flutter run
   ```
   
## 🛠️ Desenvolvido com

- [Flutter](https://flutter.dev/)
- [Provider](https://pub.dev/packages/provider)
- [Geolocator](https://pub.dev/packages/geolocator)
- [Open-Meteo API](https://open-meteo.com/)

---

## 🖼️ Créditos

- Ícone do aplicativo fornecido por [Freepik](https://www.freepik.com)
