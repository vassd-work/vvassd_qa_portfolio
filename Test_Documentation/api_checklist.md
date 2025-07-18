### ✅ Чек-лист тестирования API на примере POST запроса с данными пользователя

>Тело запроса
> >{ <br>
> >login: "test_login", <br>
> >mail: "example@mail.ru", <br>
> >password: 123456789 <br>
> >}
> 

### Общие проверки

| № | Проверка                            | Ожидаемый результат                    | Пройдена |
|---|-------------------------------------|----------------------------------------|----------|
| 1 | Успешный запрос с валидными данными | Код 201, тело с ID нового пользователя | ✅        |
| 2 | Пустое тело запроса                 | Код 400, ошибка валидации              | ✅        |
| 3 | Отсутствие токена авторизации       | Код 401                                | ✅        |
| 4 | Повторный запрос с тем же данными   | Код 409, ошибка дублирования           | ✅        |

### Проверки для парамтера тела запроса "login"

| № | Проверка                               | Ожидаемый результат                    | Пройдена  |
|---|----------------------------------------|----------------------------------------|-----------|
| 1 | Пустой параметр "login" в теле запроса | Код 400, тело с ID нового пользователя | ✅        |
| 2 | Отсутсвует параметр тела запроса       | Код 400, ошибка валидации              | ✅        |


### Проверки для парамтера тела запроса "mail"

| № | Проверка                            | Ожидаемый результат                    | Пройдена |
|---|-------------------------------------|----------------------------------------|----------|
| 1 | Успешный запрос с валидными данными | Код 201, тело с ID нового пользователя | ✅        |

### Проверки для парамтера тела запроса "password"

| № | Проверка                            | Ожидаемый результат                    | Пройдена |
|---|-------------------------------------|----------------------------------------|----------|
| 1 | Успешный запрос с валидными данными | Код 201, тело с ID нового пользователя | ✅        |