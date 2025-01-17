
# Доска объявлений

Сервис для размещения и поиска объявлений, построенный на фреймворке **Ruby on Rails**. Предоставляет функционал публикации и управления объявлениями. Включает регистрацию и авторизацию через Github Apps.

### Статус тестов и линтера:

[![Actions Status](https://github.com/Houssse/rails-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Houssse/rails-project-65/actions)
[![Lint](https://github.com/Houssse/rails-project-65/actions/workflows/lint.yml/badge.svg?branch=main)](https://github.com/Houssse/rails-project-65/actions/workflows/lint.yml)
[![Test](https://github.com/Houssse/rails-project-65/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/Houssse/rails-project-65/actions/workflows/test.yml)

---

### Технологии

- **Rails**: 7.2.2
- **Ruby**: 3.2.2
- **PostgreSQL** (или другая база данных, если используется)
- **Github Apps** для регистрации и авторизации

---

### Деплой

Приложение развернуто на хостинге **Render**:

[rails-project-65](https://rails-project-65-b29l.onrender.com)

---

### Локальный запуск

1. Клонируйте репозиторий:

   ```bash
   git clone git@github.com:Houssse/rails-project-65.git
   ```

2. Перейдите в директорию приложения:

   ```bash
   cd rails-project-65
   ```

3. Установите зависимости:

   ```bash
   make setup
   ```

4. Настройте файл `config/database.yml` для локальной работы с базой данных.

5. Для корректной работы **Github Apps** создайте собственные и добавьте их в `.env`:
   - `GITHUB_CLIENT_ID`
   - `GITHUB_CLIENT_SECRET`

6. Для заполнения базы данных тестовыми данными:

   ```bash
   rails db:seed
   ```

7. Для запуска тестов:

   ```bash
   make test
   ```

---

### Используемые гемы

- **aasm**: Гем для реализации состояний и переходов между ними в моделях. Полезен для создания автоматических и сложных бизнес-логик с состояниями объектов.
  
- **kaminari**: Пагинация для Rails. Используется для разбивки данных на страницы, упрощая отображение больших объемов информации.

- **pundit**: Гем для управления правами доступа в приложении. Позволяет определять политики доступа и контролировать, кто может выполнять те или иные действия.

- **ransack**: Гем для реализации поиска и фильтрации данных. Позволяет быстро добавлять гибкие формы поиска для моделей.

---

### Примечания

- Убедитесь, что установлены все необходимые зависимости, включая Ruby, Rails и PostgreSQL.
- Для работы с Github Apps потребуется зарегистрировать приложение на Github и получить необходимые креденциалы.
