#!/bin/bash
# Скрипт для быстрой установки и настройки oh-my-opencode

set -e

echo "🚀 Настройка Oh My OpenCode..."

# Проверка Bun
if ! command -v bun &> /dev/null; then
    echo "❌ Bun не установлен. Установите Bun: https://bun.sh"
    exit 1
fi

echo "✓ Bun установлен: $(bun --version)"

# Проверка OpenCode
if ! command -v opencode &> /dev/null; then
    echo "⚠️  OpenCode не найден в PATH"
    echo "   Убедитесь, что OpenCode установлен и доступен"
    echo "   Попробуйте перезагрузить терминал или добавить путь в PATH"
else
    echo "✓ OpenCode установлен: $(opencode --version)"
fi

# Установка зависимостей
echo ""
echo "📦 Установка зависимостей..."
bun install

# Сборка проекта
echo ""
echo "🔨 Сборка проекта..."
bun run build

# Проверка сборки
if [ -d "dist" ] && [ -f "dist/index.js" ]; then
    echo "✓ Проект успешно собран"
else
    echo "❌ Ошибка сборки"
    exit 1
fi

echo ""
echo "✅ Проект готов к использованию!"
echo ""
echo "Следующие шаги:"
echo "1. Убедитесь, что OpenCode доступен: opencode --version"
echo "2. Установите плагин: bun run dist/cli/index.js install"
echo "3. Настройте аутентификацию: opencode auth login"
echo ""
echo "Или используйте интерактивный установщик:"
echo "   bunx oh-my-opencode install"
