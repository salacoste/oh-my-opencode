# Валидация конфигурации MCP серверов

## Проверка согласно документации OpenCode

Согласно [документации OpenCode MCP Servers](https://opencode.ai/docs/mcp-servers/), для remote MCP серверов требуются:

### Обязательные поля:
- ✅ `type`: `"remote"` - **ПРИСУТСТВУЕТ**
- ✅ `url`: URL сервера - **ПРИСУТСТВУЕТ**

### Опциональные поля:
- ✅ `enabled`: Boolean - **ПРИСУТСТВУЕТ** (true)
- ✅ `headers`: Object - **ПРИСУТСТВУЕТ** (Authorization Bearer)
- ⚠️ `oauth`: Object | false - **ОТСУТСТВУЕТ** (не требуется, так как используется API key)
- ⚠️ `timeout`: Number - **ОТСУТСТВУЕТ** (будет использован дефолтный 5000ms)

## Текущая конфигурация

### ✅ opencode.json - Z.AI Web Search MCP

```json
{
  "mcp": {
    "zai-web-search": {
      "type": "remote",                    // ✅ Обязательное поле
      "url": "https://api.z.ai/mcp/web-search",  // ✅ Обязательное поле
      "enabled": true,                     // ✅ Опциональное (включено)
      "headers": {                         // ✅ Опциональное (для авторизации)
        "Authorization": "Bearer 4c156a6dc2f64fdfb33e10be6bdf26a3.mnoCGgMN8OPMD1xi"
      }
    }
  }
}
```

**Статус**: ✅ **КОРРЕКТНО** - соответствует документации OpenCode

### ✅ oh-my-opencode.json - Отключение websearch_exa

```json
{
  "disabled_mcps": ["websearch_exa"]
}
```

**Статус**: ✅ **КОРРЕКТНО** - websearch_exa отключен

### ✅ ~/.claude/.mcp.json - Удален backlog

```json
{
  "mcpServers": {}
}
```

**Статус**: ✅ **КОРРЕКТНО** - backlog удален

## Сравнение с примерами из документации

### Пример Context7 (с API key):
```json
{
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com/mcp",
      "headers": {
        "CONTEXT7_API_KEY": "{env:CONTEXT7_API_KEY}"
      }
    }
  }
}
```

### Наша конфигурация Z.AI:
```json
{
  "mcp": {
    "zai-web-search": {
      "type": "remote",
      "url": "https://api.z.ai/mcp/web-search",
      "enabled": true,
      "headers": {
        "Authorization": "Bearer 4c156a6dc2f64fdfb33e10be6bdf26a3.mnoCGgMN8OPMD1xi"
      }
    }
  }
}
```

**Различия**:
- ✅ Используем `Authorization: Bearer` вместо кастомного заголовка (стандартный формат)
- ✅ Добавлен `enabled: true` (явное указание)
- ✅ Формат полностью соответствует документации

## ⚠️ Потенциальная проблема: URL endpoint

**Текущий URL**: `https://api.z.ai/mcp/web-search`

Это предположительный URL. Возможные варианты:
1. `https://api.z.ai/mcp/web-search` (текущий)
2. `https://api.z.ai/mcp` (общий endpoint)
3. `https://mcp.z.ai/web-search` (специальный MCP домен)
4. `https://open.bigmodel.cn/api/mcp/web-search` (китайский домен)

## Рекомендации

1. ✅ **Формат конфигурации корректен** согласно документации
2. ⚠️ **Проверить URL endpoint** после перезапуска OpenCode
3. ✅ **Использовать команду для проверки**: `opencode mcp list`
4. ✅ **Использовать команду для отладки**: `opencode mcp debug zai-web-search`

## Итоговая оценка

| Критерий | Статус | Комментарий |
|----------|--------|-------------|
| Формат конфигурации | ✅ Корректно | Соответствует документации OpenCode |
| Обязательные поля | ✅ Все присутствуют | type, url |
| Опциональные поля | ✅ Присутствуют | enabled, headers |
| Отключение websearch_exa | ✅ Выполнено | disabled_mcps |
| Удаление backlog | ✅ Выполнено | Удален из ~/.claude/.mcp.json |
| URL endpoint | ⚠️ Требует проверки | Предположительный URL |

## Следующие шаги

1. Перезапустить OpenCode
2. Выполнить: `opencode mcp list` - проверить статус MCP серверов
3. Выполнить: `opencode mcp debug zai-web-search` - отладить подключение
4. Если URL неправильный, обновить его в конфигурации
