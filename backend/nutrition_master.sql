-- Create nutrition_master table
CREATE TABLE IF NOT EXISTS nutrition_master (
  nutrition_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert some sample nutrition data
INSERT INTO nutrition_master (name) VALUES 
('Protein'),
('Carbohydrates'),
('Fat'),
('Fiber'),
('Sugar'),
('Sodium'),
('Calcium'),
('Iron'),
('Vitamin A'),
('Vitamin C'),
('Vitamin D'),
('Vitamin E'),
('Vitamin K'),
('Vitamin B1 (Thiamine)'),
('Vitamin B2 (Riboflavin)'),
('Vitamin B3 (Niacin)'),
('Vitamin B6'),
('Vitamin B12'),
('Folate'),
('Biotin'),
('Pantothenic Acid'),
('Choline'),
('Potassium'),
('Magnesium'),
('Phosphorus'),
('Zinc'),
('Copper'),
('Manganese'),
('Selenium'),
('Chromium'),
('Molybdenum'),
('Iodine'),
('Chloride'),
('Sulfur'); 