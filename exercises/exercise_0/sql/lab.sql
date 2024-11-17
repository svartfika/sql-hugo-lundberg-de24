SELECT h.asked_price, h.final_price,
	ROUND(((h.final_price / h.asked_price) - 1) * 100, 2) AS diff_pct,
	-- ROUND(((h.final_price - h.asked_price) / h.asked_price) * 100 , 2) AS diff_pct2
FROM main.hemnet h
ORDER BY diff_pct DESC
LIMIT 10;