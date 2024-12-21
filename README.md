# ServerGuard Bot: Monitoramento de Servidores com Alertas em Vários Chats do Telegram

O **ServerGuard Bot** é um bot em Shell que permite monitorar a saúde do servidor, como uso de CPU, memória, e espaço em disco, e enviar alertas em tempo real para múltiplos chats do Telegram. Com a capacidade de carregar IDs de chat de um arquivo `.txt`, ele facilita o envio de mensagens para diferentes grupos e usuários de maneira eficiente.

---

## Funcionalidades

- **Monitoramento de Recursos:** Verifica periodicamente o uso de CPU, memória e espaço em disco.
- **Alertas em Múltiplos Chats:** Envia notificações de alertas para múltiplos chats do Telegram a partir de IDs carregados de um arquivo `.txt`.
- **Monitoramento de Processos Específicos:** Alerta caso processos críticos, como servidores web, parem de funcionar.
- **Relatórios de Status:** Possibilidade de gerar relatórios diários sobre o status do servidor.

---

## Pré-requisitos

Antes de usar o **ServerGuard Bot**, você precisa ter:

1. **Conta no Telegram**: Crie um bot no [BotFather](https://core.telegram.org/bots#botfather) e obtenha o token de autenticação.

2. **Dependências**:
   - **`curl`**: Utilizado para enviar as notificações via Telegram.
   - **`jq`**: Utilitário para manipulação de dados JSON (se necessário).
   - Para instalar no Ubuntu/Debian:
     ```bash
     sudo apt update && sudo apt install curl jq -y
     ```

3. **Sistema Operacional**: Compatível com Linux/macOS. Para Windows, utilize o WSL (Windows Subsystem for Linux).

---

## Configuração

### 1. Clone o Repositório

Clone o repositório para o seu servidor ou máquina local:

```bash
git clone https://github.com/henriquetourinho/ServerGuard-Bot.git
cd MultiChatGuard-Bot
```

### 2. Configuração do Script

- Abra o arquivo `multi_chat_guard.sh` e configure as variáveis:

  ```bash
  # Token do Bot no Telegram
  BOT_TOKEN="SEU_BOT_TOKEN"
  
  # Arquivo contendo os IDs dos chats (um por linha)
  CHAT_IDS_FILE="/caminho/para/chat_ids.txt"
  
  # Limites de Uso (em %)
  CPU_LIMIT=50
  MEMORY_LIMIT=50
  DISK_LIMIT=50
  ```

  - **BOT_TOKEN**: O token gerado ao criar o bot no BotFather.
  - **CHAT_IDS_FILE**: O caminho para o arquivo `.txt` que contém os IDs dos chats. Cada ID de chat deve estar em uma linha separada.

### 3. Permissões de Execução

Garanta que o script tenha permissão para execução:

```bash
chmod +x multi_chat_guard.sh
```

---

## Uso

### 1. Executando o Bot

Execute o script manualmente ou configure-o para rodar periodicamente usando o cron.

```bash
./multi_chat_guard.sh
```

### 2. Monitoramento e Alertas

O **ServerGuard Bot** irá:

1. Verificar o uso de CPU, memória e disco.
2. Enviar uma mensagem no Telegram para todos os chats contidos no arquivo de IDs, caso algum recurso ultrapasse o limite definido.

### 3. Configuração de Execução Periódica (Cron)

Você pode configurar o script para rodar automaticamente a cada 5 minutos (ou outro intervalo) com o cron.

- Edite o crontab com o comando:

  ```bash
  crontab -e
  ```

- Adicione a seguinte linha para rodar o script a cada 5 minutos:

  ```bash
  */5 * * * * /caminho/para/serverguard_bot.sh
  ```

---

## Personalização

1. **Alterar os Limites de Recursos**:
   - Modifique as variáveis `CPU_LIMIT`, `MEMORY_LIMIT`, e `DISK_LIMIT` para ajustar os limites de alerta de acordo com sua necessidade.

2. **Adicionar Outros Processos**:
   - Você pode expandir o script para monitorar outros processos críticos, como servidores web ou bancos de dados.

3. **Alterar a Mensagem do Alerta**:
   - Personalize a mensagem de alerta dentro da função `send_alert` para incluir mais informações ou um formato diferente.

---

## Dicas de Segurança

- **Proteção de Credenciais**:
  - Evite armazenar o token do bot diretamente no script. Uma alternativa é usar variáveis de ambiente para definir as credenciais:

    ```bash
    export BOT_TOKEN="SEU_BOT_TOKEN"
    export CHAT_IDS_FILE="CAMINHO_PARA_SEU_CHAT_IDS.txt"
    ```

  - No script, substitua as variáveis de ambiente:

    ```bash
    BOT_TOKEN=${BOT_TOKEN}
    CHAT_IDS_FILE=${CHAT_IDS_FILE}
    ```

---

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---

## Contribuições

Contribuições são bem-vindas! Se você tem sugestões de melhorias ou novos recursos, sinta-se à vontade para abrir issues ou enviar pull requests.

---

### **Descrição Completa:**

O **ServerGuard Bot** é uma solução eficiente para administradores de servidores que precisam monitorar vários recursos do sistema e receber alertas em múltiplos chats do Telegram. Ao utilizar um arquivo `.txt` com IDs de chat, você pode facilmente gerenciar notificações para diferentes grupos e usuários. O bot monitora não apenas o uso de CPU, memória e espaço em disco, mas também pode ser configurado para verificar o estado de processos críticos, garantindo que você seja alertado sempre que algo sair do normal.

--- 

**Se precisar de mais detalhes ou ajustes, é só avisar!**
