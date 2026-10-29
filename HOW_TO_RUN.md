# 🚀 Как запустить oh-my-opencode

## ✅ Простой ответ

**Да, достаточно просто запустить `opencode .`**

Плагин `oh-my-opencode` автоматически загружается при запуске OpenCode, так как он указан в конфигурации.

## 📋 Процесс запуска

### 1. Базовый запуск

```bash
# Перейдите в директорию вашего проекта
cd /path/to/your/project

# Запустите OpenCode
opencode .
```

### 2. Что происходит при запуске

1. **OpenCode загружает конфигурацию** из `~/.config/opencode/opencode.json`
2. **Обнаруживает плагин** `oh-my-opencode` в секции `plugin`
3. **Загружает плагин** из глобального npm пакета (`/opt/homebrew/lib/node_modules/oh-my-opencode`)
4. **Инициализирует плагин**:
   - Загружает конфигурацию из `~/.config/opencode/oh-my-opencode.json`
   - Инициализирует агентов (Sisyphus, oracle, librarian, и т.д.)
   - Подключает MCP серверы (zai-web-search, context7)
   - Настраивает LSP серверы
   - Активирует hooks (хуки жизненного цикла)

5. **Открывает TUI** (Terminal User Interface) с полным функционалом

## 🎯 Доступные команды после запуска

После запуска `opencode .` вы получите доступ к:

### Агенты
- **Sisyphus** - основной оркестратор (Claude Opus 4.5 High)
- **Planner-Sisyphus** - планировщик (Claude Opus 4.5 High)
- **oracle** - стратегия и code review (Gemini 3 Pro High)
- **librarian** - документация и OSS research (Claude Sonnet 4.5 High)
- **explore** - быстрый поиск по кодовой базе (Claude Sonnet 4.5 High)
- **frontend-ui-ux-engineer** - генерация UI (Gemini 3 Pro High)
- **document-writer** - техническая документация (Gemini 3 Flash)
- **multimodal-looker** - анализ PDF/изображений (Gemini 3 Flash)

### Инструменты
- **LSP** - языковые серверы (TypeScript, Rust, Go)
- **AST-Grep** - поиск по AST
- **Grep** - поиск по коду
- **Glob** - поиск файлов
- **MCP серверы** - zai-web-search, context7

### Hooks
- Автоматическое восстановление сессий
- Мониторинг контекстного окна
- Уведомления о сессиях
- Проверка комментариев
- И многое другое...

## 🔍 Проверка, что плагин загружен

### Способ 1: Проверить конфигурацию

```bash
cat ~/.config/opencode/opencode.json | grep -A 1 "plugin"
```

Должно быть:
```json
"plugin": [
  "oh-my-opencode"
]
```

### Способ 2: Запустить и проверить функционал

После запуска `opencode .`:
- Проверьте доступность агентов (например, Sisyphus)
- Проверьте доступность команд (например, `/oracle`, `/librarian`)
- Проверьте работу MCP серверов

### Способ 3: Использовать команду doctor

```bash
# В директории проекта
opencode doctor
```

Команда проверит:
- Установку OpenCode
- Установку плагина oh-my-opencode
- Конфигурацию
- И многое другое

## 📝 Примеры использования

### Пример 1: Базовый запуск

```bash
cd ~/my-project
opencode .
```

### Пример 2: Запуск с сообщением

```bash
cd ~/my-project
opencode run "Добавь функцию для обработки ошибок"
```

### Пример 3: Запуск в новой директории

```bash
mkdir new-project && cd new-project
opencode .
```

## ⚙️ Конфигурация

### Глобальная конфигурация

**Файл**: `~/.config/opencode/oh-my-opencode.json`

Эта конфигурация применяется ко всем проектам.

### Локальная конфигурация проекта

**Файл**: `.opencode/oh-my-opencode.json` (в корне проекта)

Эта конфигурация переопределяет глобальную для конкретного проекта.

### Приоритет конфигураций

1. **Локальная** (`.opencode/oh-my-opencode.json`) - высший приоритет
2. **Глобальная** (`~/.config/opencode/oh-my-opencode.json`) - базовые настройки

## 🐛 Устранение проблем

### Плагин не загружается

1. Проверьте, что плагин установлен:
   ```bash
   npm list -g oh-my-opencode
   ```

2. Проверьте конфигурацию OpenCode:
   ```bash
   cat ~/.config/opencode/opencode.json
   ```

3. Переустановите плагин:
   ```bash
   npm install -g oh-my-opencode@latest
   ```

### Агенты не работают

1. Проверьте конфигурацию агентов:
   ```bash
   cat ~/.config/opencode/oh-my-opencode.json
   ```

2. Проверьте настройки провайдеров:
   ```bash
   cat ~/.config/opencode/opencode.json | grep -A 10 "provider"
   ```

### MCP серверы не работают

1. Проверьте конфигурацию MCP:
   ```bash
   cat ~/.config/opencode/opencode.json | grep -A 10 "mcp"
   ```

2. Проверьте статус MCP серверов:
   ```bash
   opencode mcp list
   ```

## ✅ Чеклист перед запуском

- [ ] OpenCode установлен (`opencode --version`)
- [ ] oh-my-opencode установлен (`npm list -g oh-my-opencode`)
- [ ] Плагин указан в `opencode.json`
- [ ] Конфигурация `oh-my-opencode.json` настроена
- [ ] Провайдеры настроены (Anthropic, Google)
- [ ] MCP серверы настроены (опционально)
- [ ] LSP серверы настроены (опционально)

## 🎉 Готово!

После выполнения всех шагов просто запустите:

```bash
opencode .
```

И наслаждайтесь мощным функционалом oh-my-opencode! 🚀
