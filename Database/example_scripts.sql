/* 1. Отобрать из таблицы gorod все города, относящиеся к Чувашской Республике;
В результат необходимо вывести название города и численность населения, результат
отсортировать по возрастанию кол ва жителей*/

SELECT g.CITY_NAME, g.NASELENIE
  FROM gorod g
       JOIN region r ON r.ID = g.REGION_ID
 WHERE r.ID = 1
 ORDER BY g.NASELENIE;

/* 2. Вывести кол-во городов, хранящихся в таблице gorod, для которых не указана численность
населения*/

SELECT COUNT(*)
  FROM gorod g
 WHERE g.NASELENIE IS NULL;

/* 3. Выбрать из таблицы gorod город с наи большим кол вом населения*/

SELECT g.CITY_NAME
  FROM gorod g
 WHERE g.NASELENIE = (SELECT max(g.NASELENIE)
                        FROM gorod g);

/* 4. Удалить из таблицы gorod города с населением меньше 400000*/

DELETE
  FROM gorod g
 WHERE g.NASELENIE <400000;

/* 5. Изменить поле naselenie в таблице gorod выставив в нем для городов Чувашской
Республики значение 200000*/

UPDATE gorod g
   SET g.NASELENIE = 200000
 WHERE g.REGION_ID = 1;

/* 6. Отобрать из таблицы gorod все города, начинающиеся на букву К*/

SELECT g.CITY_NAME
  FROM gorod g
 WHERE LOWER(g.CITY_NAME) LIKE LOWER('К%');

 /* 7. Написать скрипт, позволяющий определить кол-во городов, которое хранится в таблице
gorod для каждого региона, т.е. результат должен быть в виде:
название соответствующего региона кол во городов*/


/* Данные из запроса будут выведены в табличный вид */

  SELECT r.REGION_NAME,
       COUNT(g.CITY_NAME) AS city_count
  FROM gorod g
       JOIN region r ON r.ID = g.REGION_ID
  GROUP BY r.REGION_NAME;

/* Скрипт, который выведет данные в табличную структуру */

-- Создаем временную таблицу
CREATE GLOBAL TEMPORARY TABLE temp_region_city_count (
  region_name VARCHAR2(2000),
  city_count  NUMBER
) ON COMMIT PRESERVE ROWS;

DECLARE
  CURSOR c_gorod IS
     SELECT r.REGION_NAME,
            COUNT(g.CITY_NAME) AS city_count
       FROM "Gorod_region".gorod g
            JOIN "Gorod_region".region r ON r.ID = g.REGION_ID
       GROUP BY r.REGION_NAME;

  v_region_name "Gorod_region".region.region_name%TYPE;
  v_city_count  NUMBER;

BEGIN
  OPEN c_gorod; -- Открытие курсора
  LOOP -- Цикл для обхода всех записей курсора
    FETCH c_gorod INTO v_region_name, v_city_count; -- Извлечение данных из курсора в переменные
    EXIT WHEN c_gorod%NOTFOUND;

    -- Вставка данных во временную таблицу
    INSERT INTO temp_region_city_count (region_name, city_count)
    VALUES (v_region_name, v_city_count);
  END LOOP;

  CLOSE c_gorod; -- Закрытие курсора
END;
/

-- Извлекаем данные из временной таблицы
SELECT REGION_NAME, CITY_COUNT
  FROM temp_region_city_count;

-- Удаляем временную таблицу, если она больше не нужна
DROP TABLE temp_region_city_count;

/* Данные будут выведены списокм */
DECLARE
  CURSOR c_gorod IS
     SELECT r.REGION_NAME,
            COUNT(g.CITY_NAME) AS city_count
       FROM gorod g
            JOIN region r ON r.ID = g.REGION_ID
       GROUP BY r.REGION_NAME;

  v_region_name r.REGION_NAME%TYPE;
  v_city_count  NUMBER;

BEGIN
  OPEN c_gorod; -- Открытие курсора
  LOOP -- Цикл для обхода всех записей курсора
    FETCH c_gorod INTO v_region_name, v_city_count;  -- Извлечение данных из курсора в переменные
    EXIT WHEN c_gorod%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('Регион: ' || v_region_name || ' - Количество городов: ' || v_city_count); -- Вывод результата
  END LOOP;

  CLOSE c_gorod; -- Закрытие курсора
END;
/
