# Настройка Z.AI Web Search MCP сервера

## ✅ Что сделано

1. **Отключен websearch_exa** в `oh-my-opencode.json`:
   ```json
   "disabled_mcps": ["websearch_exa"]
   ```

2. **Добавлен Z.AI Web Search MCP** в `opencode.json`:
   ```json
   {
     "mcp": {
       "zai-web-search": {
         "type": "remote",
         "url": "https://api.z.ai/api/mcp/web_search_prime/mcp",
         "enabled": true,
         "headers": {
           "Authorization": "Bearer 4c156a6dc2f64fdfb33e10be6bdf26a3.mnoCGgMN8OPMD1xi"
         }
       }
     }
   }
   ```

## ✅ Правильный URL (из документации Z.AI)

**Текущий URL**: `https://api.z.ai/api/mcp/web_search_prime/mcp`

Согласно [документации Z.AI](https://docs.z.ai/guides/tools/web-search), правильный endpoint для MCP сервера:
- **streamableHttp**: `https://api.z.ai/api/mcp/web_search_prime/mcp` (текущий)
- **SSE**: `https://api.z.ai/api/mcp/web_search/sse` (альтернативный вариант)

## 📋 Формат конфигурации (согласно документации OpenCode)

Согласно [документации OpenCode](https://opencode.ai/docs/mcp-servers/), для remote MCP серверов используется формат:

```json
{
  "mcp": {
    "server-name": {
      "type": "remote",
      "url": "https://mcp-server-url",
      "enabled": true,
      "headers": {
        "Authorization": "Bearer API_KEY"
      }
    }
  }
}
```

## 🔍 Как найти правильный URL?

1. **Проверьте документацию Z.AI** на наличие MCP endpoint
2. **Проверьте через curl**:
   ```bash
   curl -H "Authorization: Bearer 4c156a6dc2f64fdfb33e10be6bdf26a3.mnoCGgMN8OPMD1xi" \
        https://api.z.ai/mcp/web-search
   ```
3. **Проверьте логи OpenCode** после перезапуска - там будут ошибки подключения, если URL неправильный

## 🚀 Следующие шаги

1. **Перезапустите OpenCode**
2. **Проверьте логи** на наличие ошибок подключения к MCP серверу
3. **Если URL неправильный**, обновите его в `opencode.json`
4. **Протестируйте** использование веб-поиска в OpenCode

## 📝 Текущая конфигурация

Файл: `~/.config/opencode/opencode.json`

```json
{
  "mcp": {
    "zai-web-search": {
      "type": "remote",
      "url": "https://api.z.ai/api/mcp/web_search_prime/mcp",
      "enabled": true,
      "headers": {
        "Authorization": "Bearer 4c156a6dc2f64fdfb33e10be6bdf26a3.mnoCGgMN8OPMD1xi"
      }
    }
  }
}
```

## 🔄 Альтернативные варианты URL (если текущий не работает)

### Вариант 1: SSE endpoint
```json
"url": "https://api.z.ai/api/mcp/web_search/sse"
```
*Примечание: Для SSE может потребоваться передача API key через query параметр*

### Вариант 2: Базовый web_search endpoint
```json
"url": "https://api.z.ai/api/mcp/web_search/mcp"
```

## ✅ Проверка работы

После перезапуска OpenCode:

1. Проверьте статус MCP серверов: `opencode mcp list`
2. Попробуйте использовать веб-поиск в запросе
3. Проверьте логи на наличие ошибок

## 📚 Ссылки

- [OpenCode MCP Servers Documentation](https://opencode.ai/docs/mcp-servers/)
- [Z.AI Web Search Documentation](https://docs.z.ai/guides/tools/web-search)
