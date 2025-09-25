-- Update existing pharmacy categories to use correct image directory
UPDATE `master_categories` 
SET `icon_url` = REPLACE(`icon_url`, 'master_cat_food_img/', 'master_cat_pharmacy_img/')
WHERE `module` = 'Pharmacy' 
AND `icon_url` LIKE 'master_cat_food_img/%';

-- Verify the update
SELECT `maste_cat_food_id`, `name`, `icon_url`, `module`, `created_at` 
FROM `master_categories` 
WHERE `module` = 'Pharmacy' 
ORDER BY `created_at` DESC;