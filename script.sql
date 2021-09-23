--Посчитать сколько пользователей живет в каждой стране и каждом городе

SELECT city.name, country.name, COUNT(users.name)
FROM `users`
         LEFT JOIN `city` on users.city_id = city.id
         LEFT JOIN `country` on city.country_id = country.id
GROUP BY city.name, country.name

--Посчитать сколько пользователей живет в каждой стране и в каждом городе которые авторизовались за последние трое суток.
SELECT city.name, country.name, COUNT(users.name)
FROM `users`
         LEFT JOIN `city` on users.city_id = city.id
         LEFT JOIN `country` on city.country_id = country.id
         LEFT JOIN `storage_date_authorization` as storage_date on users.id = storage_date.user_id
WHERE storage_date.date BETWEEN DATE_SUB(NOW(),
                                         INTERVAL 3 DAY) AND NOW()
GROUP BY city.name, country.name
/**
  Найти ту страну и тот город с которого максимальное количество авторизаций
  за (все время/за последние три дня/за последний месяц/квартал/год)
 */
--за все время
SELECT city.name, country.name, date, COUNT (user_id) cnt
FROM `storage_date_authorization` as storage_date
    LEFT JOIN `users`
on users.id = storage_date.user_id
    LEFT JOIN `city` on users.city_id = city.id
    LEFT JOIN `country` on city.country_id = country.id
GROUP BY city.name, country.name, date
ORDER BY cnt DESC LIMIT 1

--за три дня
SELECT city.name, country.name, date, COUNT (user_id) cnt
FROM `storage_date_authorization` as storage_date
    LEFT JOIN `users`
on users.id = storage_date.user_id
    LEFT JOIN `city` on users.city_id = city.id
    LEFT JOIN `country` on city.country_id = country.id

WHERE storage_date.date BETWEEN DATE_SUB(NOW()
    , INTERVAL 3 DAY)
  AND NOW()
GROUP BY city.name, country.name, date
ORDER BY cnt DESC LIMIT 1

--за месяц
SELECT city.name, country.name, date, COUNT (user_id) cnt
FROM `storage_date_authorization` as storage_date
    LEFT JOIN `users`
on users.id = storage_date.user_id
    LEFT JOIN `city` on users.city_id = city.id
    LEFT JOIN `country` on city.country_id = country.id

WHERE storage_date.date BETWEEN DATE_SUB(NOW()
    , INTERVAL 30 DAY)
  AND NOW()
GROUP BY city.name, country.name, date
ORDER BY cnt DESC LIMIT 1

--за квартал
SELECT city.name, country.name, date, COUNT (user_id) cnt
FROM `storage_date_authorization` as storage_date
    LEFT JOIN `users`
on users.id = storage_date.user_id
    LEFT JOIN `city` on users.city_id = city.id
    LEFT JOIN `country` on city.country_id = country.id

WHERE storage_date.date BETWEEN DATE_SUB(NOW()
    , INTERVAL 92 DAY)
  AND NOW()
GROUP BY city.name, country.name, date
ORDER BY cnt DESC LIMIT 1

--за год
SELECT city.name, country.name, date, COUNT (user_id) cnt
FROM `storage_date_authorization` as storage_date
    LEFT JOIN `users`
on users.id = storage_date.user_id
    LEFT JOIN `city` on users.city_id = city.id
    LEFT JOIN `country` on city.country_id = country.id

WHERE storage_date.date BETWEEN DATE_SUB(NOW()
    , INTERVAL 360 DAY)
  AND NOW()
GROUP BY city.name, country.name, date
ORDER BY cnt DESC LIMIT 1


--Вывести список стран по возрастанию количества пользователей в стране. (Аналогично сделать для городов)
SELECT city.name, country.name
FROM `users`
         LEFT JOIN `city` on users.city_id = city.id
         LEFT JOIN `country` on city.country_id = country.id
GROUP BY city.name, country.name
ORDER BY COUNT(users.name) ASC


--Посчитать сколько проживает пользователей по ролям в каждом городе/каждой стране

SELECT city.name, country.name, COUNT(users.name), user_role.name
FROM `users`
         LEFT JOIN `city` on users.city_id = city.id
         LEFT JOIN `country` on city.country_id = country.id
         LEFT JOIN group_user_role as group_user on users.id = group_user.user_id
         LEFT JOIN user_role on user_role.id = group_user.role_id
WHERE group_user.role_id IS NOT NULL
GROUP BY city.name, country.name, user_role.name
--Посчитать сколько раз заходили пользователи с ролью админ за последний месяц в разрезе каждой страны и города
SELECT city.name, country.name, user_role.name, COUNT(storage_date.user_id) cnt
FROM `storage_date_authorization` as storage_date
         LEFT JOIN `users` on users.id = storage_date.user_id
         LEFT JOIN `city` on users.city_id = city.id
         LEFT JOIN `country` on city.country_id = country.id

         LEFT JOIN group_user_role as group_user on users.id = group_user.user_id
         LEFT JOIN `user_role` on user_role.id_role = group_user.role_id
WHERE storage_date.user_id = 1
  AND storage_date.date BETWEEN DATE_SUB(NOW(),
                                         INTERVAL 30 DAY) AND NOW()
GROUP BY city.name, country.name, user_role.name

--Найти всех пользователей у которых нет ни одной роли

SELECT name
FROM `users`
         LEFT JOIN group_user_role as group_user on users.id = group_user.user_id
WHERE group_user.role_id IS NULL
--Посчитать сколько проживает в каждой стране и в каждом городе пользователей по всем существующим ролям
SELECT city.name, country.name, COUNT(users.name)
FROM `users`
         LEFT JOIN `city` on users.city_id = city.id
         LEFT JOIN `country` on city.country_id = country.id
         LEFT JOIN group_user_role as group_user on users.id = group_user.user_id
WHERE group_user.role_id IS NOT NULL
GROUP BY city.name, country.name