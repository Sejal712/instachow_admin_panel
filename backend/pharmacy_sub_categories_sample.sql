-- Sample pharmacy sub-categories
-- Note: Make sure you have pharmacy categories in master_categories table first
-- You can check existing pharmacy categories with: SELECT * FROM master_categories WHERE module = 'Pharmacy';

-- Insert sample pharmacy sub-categories
INSERT INTO sub_categories (name, description, master_cat_food_id, created_at) VALUES
-- Assuming you have pharmacy categories with IDs 29, 30, 31, 32, 34, etc.
-- Replace these IDs with actual pharmacy category IDs from your database

('Prescription Medicines', 'Medicines that require a doctor\'s prescription', 29, NOW()),
('OTC Medicines', 'Over-the-counter medicines available without prescription', 29, NOW()),
('Vitamins & Supplements', 'Dietary supplements, vitamins, and minerals', 29, NOW()),
('First Aid Supplies', 'Bandages, antiseptics, and basic first aid items', 30, NOW()),
('Medical Devices', 'Blood pressure monitors, thermometers, etc.', 30, NOW()),
('Personal Care', 'Toothpaste, shampoo, soap, and hygiene products', 30, NOW()),
('Baby Care', 'Baby formula, diapers, and infant care products', 31, NOW()),
('Elderly Care', 'Adult diapers, mobility aids, and senior care products', 31, NOW()),
('Health Monitors', 'Glucose meters, pulse oximeters, and health tracking devices', 32, NOW()),
('Respiratory Care', 'Inhalers, nebulizers, and breathing aids', 32, NOW()),
('Pain Management', 'Pain relievers, heating pads, and pain relief products', 34, NOW()),
('Digestive Health', 'Antacids, probiotics, and digestive aids', 34, NOW());

-- Update the master_cat_food_id values above to match your actual pharmacy category IDs
-- To find your pharmacy category IDs, run:
-- SELECT maste_cat_food_id, name FROM master_categories WHERE module = 'Pharmacy';
