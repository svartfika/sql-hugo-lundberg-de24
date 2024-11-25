DESC;
SUMMARIZE main.cleaned_seasonality;

SELECT DISTINCT year FROM main.cleaned_seasonality ORDER BY year;

SELECT food FROM main.cleaned_seasonality GROUP BY food;


SELECT
    food,
    SUM(interest) as interest_food_total
FROM main.cleaned_seasonality
GROUP BY food
ORDER BY interest_food_total DESC
LIMIT 5;


SELECT food, year, month, SUM(interest) as interest_food_total
FROM main.cleaned_seasonality
GROUP BY food, year, month
HAVING food = 'ice-cream'
ORDER BY year DESC, month DESC, interest_food_total DESC, food ASC;


SELECT year, sum(interest) AS interest_all_total
FROM main.cleaned_seasonality
GROUP BY year
ORDER BY year DESC;