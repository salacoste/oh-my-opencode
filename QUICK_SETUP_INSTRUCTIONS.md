# Быстрая инструкция по настройке OpenCode с Thinking Mode

## ✅ Что уже сделано

Конфигурация обновлена автоматически! Файл `~/.config/opencode/oh-my-opencode.json` уже содержит все необходимые изменения.

## 📋 Что изменилось

### 1. Включен Thinking Mode для всех критичных агентов:

- ✅ **Sisyphus**: `claude-opus-4-5` → `claude-opus-4-5-high` (thinking включен)
- ✅ **librarian**: `claude-sonnet-4-5` → `claude-sonnet-4-5-high` (thinking включен)
- ✅ **explore**: `claude-haiku-4-5` → `claude-sonnet-4-5-high` (upgrade + thinking)
- ✅ **document-writer**: `gemini-3-flash` → `gemini-3-pro-low` (upgrade + thinking)

### 2. Остались без изменений (уже оптимальны):

- ✅ **oracle**: `gemini-3-pro-high` (thinking уже включен)
- ✅ **frontend-ui-ux-engineer**: `gemini-3-pro-high` (thinking уже включен)
- ✅ **multimodal-looker**: `gemini-3-flash` (thinking не критичен для анализа изображений)

## 🚀 Что нужно сделать сейчас

### Шаг 1: Проверьте конфигурацию

```bash
# Проверьте, что файл обновлен
cat ~/.config/opencode/oh-my-opencode.json
```

Вы должны увидеть:
- `Sisyphus` использует `claude-opus-4-5-high`
- `explore` использует `claude-sonnet-4-5-high` (не haiku!)
- `librarian` использует `claude-sonnet-4-5-high`
- `document-writer` использует `gemini-3-pro-low`

### Шаг 2: Проверьте наличие моделей в opencode.json

```bash
# Проверьте, что модели с thinking доступны
cat ~/.config/opencode/opencode.json | grep -A 5 "claude-opus-4-5-high"
cat ~/.config/opencode/opencode.json | grep -A 5 "claude-sonnet-4-5-high"
```

Должны быть видны:
- `"thinking": { "type": "enabled", "budgetTokens": 64000 }`

### Шаг 3: Перезапустите OpenCode

1. Закройте все запущенные сессии OpenCode
2. Запустите OpenCode заново: `opencode`
3. Проверьте статус агентов

## 📊 Итоговая конфигурация

| Агент | Модель | Thinking | Статус |
|-------|--------|----------|--------|
| **Sisyphus** | claude-opus-4-5-high | ✅ | Обновлено |
| **oracle** | gemini-3-pro-high | ✅ | Без изменений |
| **librarian** | claude-sonnet-4-5-high | ✅ | Обновлено |
| **explore** | claude-sonnet-4-5-high | ✅ | **UPGRADE** (Haiku → Sonnet) |
| **frontend-ui-ux-engineer** | gemini-3-pro-high | ✅ | Без изменений |
| **document-writer** | gemini-3-pro-low | ✅ | **UPGRADE** (Flash → Pro) |
| **multimodal-looker** | gemini-3-flash | ❌ | Без изменений |

## ⚠️ Важные замечания

1. **Thinking Mode** увеличивает:
   - Время ответа (модель "думает" перед ответом)
   - Потребление токенов (budgetTokens: 64000 для Claude)
   - Качество рассуждений и точность ответов

2. **Upgrade explore агента**:
   - Haiku → Sonnet: более точный поиск, но дороже
   - Thinking mode: лучшее понимание сложных запросов

3. **Upgrade document-writer**:
   - Flash → Pro Low: более качественное письмо
   - Thinking mode: более структурированная документация

## 🔄 Откат изменений (если нужно)

Если что-то пошло не так, можно вернуть старую конфигурацию:

```bash
# Найдите резервную копию (если создавали)
ls -la ~/.config/opencode/oh-my-opencode.json*

# Или верните вручную:
# Sisyphus: anthropic/claude-opus-4-5
# librarian: anthropic/claude-sonnet-4-5
# explore: anthropic/claude-haiku-4-5
# document-writer: google/gemini-3-flash
```

## ✅ Проверка работы

После перезапуска OpenCode:

1. Запустите тестовый запрос
2. Проверьте, что агенты используют правильные модели
3. В ответах должны появляться thinking blocks (для Claude моделей)

## 📝 Дополнительная информация

Подробная инструкция сохранена в файле `SETUP_OPencode_WITH_THINKING.md`
