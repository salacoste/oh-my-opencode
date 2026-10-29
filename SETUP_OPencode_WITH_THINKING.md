# Инструкция по настройке OpenCode с Thinking Mode

## Обзор изменений

1. ✅ Включить Thinking Mode для всех агентов, где это возможно
2. ✅ Заменить Claude Haiku на Claude Sonnet для агента `explore`
3. ✅ Использовать модели с явной поддержкой thinking в конфигурации

## Шаг 1: Обновление конфигурации агентов

Обновим файл `~/.config/opencode/oh-my-opencode.json`:

### Изменения:

1. **Sisyphus**: `claude-opus-4-5` → `claude-opus-4-5-high` (thinking включен)
2. **librarian**: `claude-sonnet-4-5` → `claude-sonnet-4-5-high` (thinking включен)
3. **explore**: `claude-haiku-4-5` → `claude-sonnet-4-5-high` (upgrade + thinking)
4. **document-writer**: `gemini-3-flash` → `gemini-3-pro-low` (thinking включен, опционально)
5. **multimodal-looker**: оставить `gemini-3-flash` (thinking не критичен для анализа изображений)

## Шаг 2: Выполнение команд

Выполните следующие команды в терминале:

```bash
# 1. Создайте резервную копию текущей конфигурации
cp ~/.config/opencode/oh-my-opencode.json ~/.config/opencode/oh-my-opencode.json.backup

# 2. Обновите конфигурацию агентов
cat > ~/.config/opencode/oh-my-opencode.json << 'EOF'
{
  "$schema": "https://raw.githubusercontent.com/salacoste/oh-my-opencode/master/assets/oh-my-opencode.schema.json",
  
  // Отключить встроенную Google авторизацию, используем прокси
  "google_auth": false,
  
  // Настройка агентов для работы через Antigravity прокси с Thinking Mode
  "agents": {
    // Главный оркестратор - использует Claude Opus 4.5 High с Thinking
    "Sisyphus": {
      "model": "anthropic/claude-opus-4-5-high",
      "temperature": 0.1
    },
    
    // Архитектор и код-ревью - использует Gemini 3 Pro High с Thinking
    "oracle": {
      "model": "google/gemini-3-pro-high",
      "temperature": 0.2
    },
    
    // Документация и исследования - использует Claude Sonnet 4.5 High с Thinking
    "librarian": {
      "model": "anthropic/claude-sonnet-4-5-high",
      "temperature": 0.1
    },
    
    // Быстрый поиск по кодовой базе - UPGRADE: Claude Sonnet 4.5 High с Thinking (было Haiku)
    "explore": {
      "model": "anthropic/claude-sonnet-4-5-high",
      "temperature": 0.1
    },
    
    // Фронтенд разработка - использует Gemini 3 Pro High с Thinking
    "frontend-ui-ux-engineer": {
      "model": "google/gemini-3-pro-high",
      "temperature": 0.2
    },
    
    // Техническая документация - использует Gemini 3 Pro Low с Thinking (upgrade от Flash)
    "document-writer": {
      "model": "google/gemini-3-pro-low",
      "temperature": 0.3
    },
    
    // Анализ PDF/изображений - использует Gemini 3 Flash (thinking не критичен)
    "multimodal-looker": {
      "model": "google/gemini-3-flash",
      "temperature": 0.1
    }
  }
}
EOF

# 3. Проверьте конфигурацию
cat ~/.config/opencode/oh-my-opencode.json

# 4. Проверьте, что OpenCode видит конфигурацию
opencode --version
```

## Шаг 3: Проверка конфигурации моделей

Убедитесь, что в `~/.config/opencode/opencode.json` есть все необходимые модели:

```bash
# Проверьте наличие моделей с thinking
cat ~/.config/opencode/opencode.json | jq '.provider.anthropic.models | keys'
```

Должны быть доступны:
- ✅ `claude-opus-4-5-high` (thinking: enabled)
- ✅ `claude-sonnet-4-5-high` (thinking: enabled)

## Шаг 4: Перезапуск OpenCode

После обновления конфигурации:

1. Закройте все запущенные сессии OpenCode
2. Перезапустите OpenCode
3. Проверьте, что агенты используют правильные модели

## Итоговая конфигурация агентов

| Агент | Модель | Thinking | Изменение |
|-------|--------|----------|-----------|
| **Sisyphus** | claude-opus-4-5-high | ✅ | Включен thinking |
| **oracle** | gemini-3-pro-high | ✅ | Уже был |
| **librarian** | claude-sonnet-4-5-high | ✅ | Включен thinking |
| **explore** | claude-sonnet-4-5-high | ✅ | **UPGRADE**: Haiku → Sonnet + thinking |
| **frontend-ui-ux-engineer** | gemini-3-pro-high | ✅ | Уже был |
| **document-writer** | gemini-3-pro-low | ✅ | **UPGRADE**: Flash → Pro Low + thinking |
| **multimodal-looker** | gemini-3-flash | ❌ | Оставлен без thinking (не критичен) |

## Преимущества изменений

1. **Thinking Mode включен** для всех критичных агентов:
   - Sisyphus: лучшее планирование и делегирование
   - librarian: более глубокий анализ документации
   - explore: более точный поиск по кодовой базе
   - document-writer: более качественное техническое письмо

2. **Upgrade explore агента**:
   - Haiku → Sonnet: более точный и контекстный поиск
   - Thinking mode: лучшее понимание сложных запросов

3. **Upgrade document-writer**:
   - Flash → Pro Low: более качественное письмо
   - Thinking mode: более структурированная документация

## Откат изменений (если нужно)

Если что-то пошло не так, восстановите резервную копию:

```bash
cp ~/.config/opencode/oh-my-opencode.json.backup ~/.config/opencode/oh-my-opencode.json
```

## Проверка работы

После перезапуска OpenCode проверьте:

1. Запустите OpenCode
2. Проверьте статус агентов (должны показывать правильные модели)
3. Сделайте тестовый запрос и проверьте, что thinking blocks появляются в ответах

## Примечания

- **Thinking mode** увеличивает время ответа и потребление токенов, но значительно улучшает качество рассуждений
- **Claude Sonnet** дороже Haiku, но обеспечивает более точные результаты
- **Gemini 3 Pro Low** быстрее Pro High, но все еще имеет thinking mode
