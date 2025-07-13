# Многоэтапная сборка для оптимизации размера образа
FROM node:20-alpine AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json для кэширования зависимостей
COPY package*.json ./

# Устанавливаем все зависимости (включая dev)
RUN npm ci

# Копируем исходный код
COPY . .

# Собираем приложение
RUN npm run build

# Устанавливаем только продакшн зависимости
RUN npm ci --only=production && npm cache clean --force


# Открываем порт
EXPOSE 3000

ENV NODE_ENV=production

# Команда запуска
CMD ["npm", "start"]