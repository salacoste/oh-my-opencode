# Настройка Planner-Sisyphus с Thinking Mode

## Что такое Planner-Sisyphus?

**Planner-Sisyphus** - это специализированный агент планирования в oh-my-opencode, который:

1. **Работает в READ-ONLY режиме** - не может редактировать файлы, только анализировать и планировать
2. **Создает детальные планы работ** перед началом реализации
3. **Использует explore и librarian агентов** для сбора контекста перед планированием
4. **Включен по умолчанию** (`planner_enabled: true`)

## Как работает Planner-Sisyphus?

### Основные функции:

1. **Анализ требований** - читает и анализирует задачу пользователя
2. **Сбор контекста** - использует explore и librarian для исследования кодовой базы и документации
3. **Создание плана** - формирует детальный план работ с разбивкой на задачи
4. **READ-ONLY режим** - не может редактировать файлы, только планировать

### Ограничения:

- ❌ **Не может редактировать файлы** (кроме `.sisyphus/plans/*.md` и `.sisyphus/drafts/*.md`)
- ❌ **Не может выполнять bash команды** (только read-only: `ls`, `grep`, `git log`, etc.)
- ✅ **Может читать файлы** для анализа
- ✅ **Может использовать explore и librarian** для исследования
- ✅ **Может создавать планы** в директории `.sisyphus/`

## Текущая конфигурация

Planner-Sisyphus использует:
- **Модель по умолчанию**: Берется из глобальной модели OpenCode (`config.model`)
- **Промпт**: Специальный READ-ONLY промпт из `plan-prompt.ts`
- **Разрешения**: Только чтение (edit: deny, bash: read-only)
- **Цвет**: `#6495ED` (Cornflower Blue)

## Настройка Planner-Sisyphus с Thinking Mode

### Вариант 1: Настройка через agents (рекомендуется)

Добавьте конфигурацию Planner-Sisyphus в `~/.config/opencode/oh-my-opencode.json`:

```json
{
  "agents": {
    "Planner-Sisyphus": {
      "model": "anthropic/claude-opus-4-5-high",
      "temperature": 0.1
    }
  }
}
```

### Вариант 2: Полная конфигурация

```json
{
  "sisyphus_agent": {
    "planner_enabled": true,
    "replace_plan": true
  },
  "agents": {
    "Planner-Sisyphus": {
      "model": "anthropic/claude-opus-4-5-high",
      "temperature": 0.1,
      "description": "Plan agent with thinking mode (OhMyOpenCode version)"
    }
  }
}
```

## Рекомендуемые модели для Planner-Sisyphus

### 1. **Claude Opus 4.5 High** (рекомендуется)
```json
{
  "agents": {
    "Planner-Sisyphus": {
      "model": "anthropic/claude-opus-4-5-high",
      "temperature": 0.1
    }
  }
}
```
- ✅ Thinking mode включен
- ✅ Максимальное качество планирования
- ✅ Лучшее понимание сложных задач

### 2. **Claude Sonnet 4.5 High** (баланс)
```json
{
  "agents": {
    "Planner-Sisyphus": {
      "model": "anthropic/claude-sonnet-4-5-high",
      "temperature": 0.1
    }
  }
}
```
- ✅ Thinking mode включен
- ✅ Быстрее и дешевле Opus
- ✅ Хорошее качество планирования

### 3. **Gemini 3 Pro High** (альтернатива)
```json
{
  "agents": {
    "Planner-Sisyphus": {
      "model": "google/gemini-3-pro-high",
      "temperature": 0.2
    }
  }
}
```
- ✅ Thinking mode включен
- ✅ Большой контекст (1M токенов)
- ✅ Хорошо для сложных проектов

## Полная конфигурация с Thinking Mode

Обновленный файл `~/.config/opencode/oh-my-opencode.json`:

```json
{
  "$schema": "https://raw.githubusercontent.com/salacoste/oh-my-opencode/master/assets/oh-my-opencode.schema.json",
  
  "google_auth": false,
  
  "sisyphus_agent": {
    "planner_enabled": true,
    "replace_plan": true
  },
  
  "agents": {
    "Sisyphus": {
      "model": "anthropic/claude-opus-4-5-high",
      "temperature": 0.1
    },
    
    "Planner-Sisyphus": {
      "model": "anthropic/claude-opus-4-5-high",
      "temperature": 0.1
    },
    
    "oracle": {
      "model": "google/gemini-3-pro-high",
      "temperature": 0.2
    },
    
    "librarian": {
      "model": "anthropic/claude-sonnet-4-5-high",
      "temperature": 0.1
    },
    
    "explore": {
      "model": "anthropic/claude-sonnet-4-5-high",
      "temperature": 0.1
    },
    
    "frontend-ui-ux-engineer": {
      "model": "google/gemini-3-pro-high",
      "temperature": 0.2
    },
    
    "document-writer": {
      "model": "google/gemini-3-pro-low",
      "temperature": 0.3
    },
    
    "multimodal-looker": {
      "model": "google/gemini-3-flash",
      "temperature": 0.1
    }
  }
}
```

## Как использовать Planner-Sisyphus?

### 1. Автоматическое использование

Planner-Sisyphus автоматически активируется, когда:
- Пользователь запрашивает планирование задачи
- Sisyphus определяет, что нужен детальный план перед реализацией
- Используется команда `/plan` или режим планирования

### 2. Ручной вызов

Вы можете явно запросить планирование:
```
Планируй задачу: добавить новую функцию авторизации
```

### 3. Workflow с Planner-Sisyphus

1. **Пользователь запрашивает задачу**
2. **Planner-Sisyphus активируется** (READ-ONLY режим)
3. **Сбор контекста**:
   - Использует explore для поиска в кодовой базе
   - Использует librarian для поиска документации
4. **Создание плана**:
   - Анализирует требования
   - Разбивает на подзадачи
   - Создает план в `.sisyphus/plans/`
5. **Пользователь проверяет план**
6. **Sisyphus выполняет план** (после одобрения)

## Проверка работы Planner-Sisyphus

### 1. Проверьте конфигурацию

```bash
cat ~/.config/opencode/oh-my-opencode.json | grep -A 5 "Planner-Sisyphus"
```

### 2. Проверьте, что агент доступен

В OpenCode интерфейсе должен быть виден агент "Planner-Sisyphus" с цветом #6495ED

### 3. Протестируйте планирование

Запросите планирование простой задачи:
```
Создай план для добавления новой функции в проект
```

Planner-Sisyphus должен:
- Проанализировать задачу
- Собрать контекст через explore/librarian
- Создать детальный план
- НЕ пытаться редактировать файлы

## Отключение Planner-Sisyphus

Если нужно отключить Planner-Sisyphus:

```json
{
  "sisyphus_agent": {
    "planner_enabled": false
  }
}
```

## Дополнительные настройки

### Изменение цвета

```json
{
  "agents": {
    "Planner-Sisyphus": {
      "model": "anthropic/claude-opus-4-5-high",
      "color": "#FF6B6B"
    }
  }
}
```

### Кастомный промпт

```json
{
  "agents": {
    "Planner-Sisyphus": {
      "model": "anthropic/claude-opus-4-5-high",
      "prompt_append": "Всегда создавай планы в формате Markdown с чекбоксами для каждой задачи."
    }
  }
}
```

## Преимущества Thinking Mode для Planner-Sisyphus

1. **Более глубокий анализ** - thinking mode помогает лучше понять сложные задачи
2. **Лучшее планирование** - более структурированные и детальные планы
3. **Учет зависимостей** - лучшее понимание связей между задачами
4. **Предвидение проблем** - выявление потенциальных проблем до начала реализации

## Примечания

- Planner-Sisyphus **не может редактировать файлы** - это по дизайну
- Планы сохраняются в `.sisyphus/plans/` и `.sisyphus/drafts/`
- После создания плана используйте `/start-work` для начала реализации
- Thinking mode увеличивает время планирования, но улучшает качество
