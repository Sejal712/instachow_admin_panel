-- Add Pharmacy categories to master_categories table
INSERT INTO `master_categories` (`name`, `icon_url`, `module`, `created_at`) VALUES
('Prescriptions', 'master_cat_pharmacy_img/prescriptions.jpg', 'Pharmacy', NOW()),
('OTC Medicine', 'master_cat_pharmacy_img/otc_medicine.jpg', 'Pharmacy', NOW()),
('Vitamins & Supplements', 'master_cat_pharmacy_img/vitamins.jpg', 'Pharmacy', NOW()),
('Personal Care', 'master_cat_pharmacy_img/personal_care.jpg', 'Pharmacy', NOW()),
('Health Devices', 'master_cat_pharmacy_img/health_devices.jpg', 'Pharmacy', NOW()),
('Baby Care', 'master_cat_pharmacy_img/baby_care.jpg', 'Pharmacy', NOW()),
('First Aid', 'master_cat_pharmacy_img/first_aid.jpg', 'Pharmacy', NOW()),
('Medical Equipment', 'master_cat_pharmacy_img/medical_equipment.jpg', 'Pharmacy', NOW());

-- Add more nutrition items for pharmacy products
INSERT INTO `nutrition_master` (`name`, `created_at`) VALUES
('Calcium', NOW()),
('Iron', NOW()),
('Vitamin D', NOW()),
('Vitamin B12', NOW()),
('Folic Acid', NOW()),
('Omega-3', NOW()),
('Probiotics', NOW()),
('Magnesium', NOW()),
('Zinc', NOW()),
('Vitamin C', NOW());

-- Add more allergen items for pharmacy products
INSERT INTO `allergen_master` (`name`, `created_at`) VALUES
('Gelatin', NOW()),
('Lactose', NOW()),
('Starch', NOW()),
('Artificial Colors', NOW()),
('Artificial Flavors', NOW()),
('Preservatives', NOW()),
('Titanium Dioxide', NOW()),
('Shellac', NOW()),
('Carmine', NOW()),
('Talc', NOW());
