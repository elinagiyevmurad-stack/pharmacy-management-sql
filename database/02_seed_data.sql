USE pharmacy_db;

INSERT INTO suppliers (name, phone, email, address) VALUES
('MedPharma Az',     '012-555-1001', 'info@medpharma.az',    'Nizami küç. 45, Bakı'),
('HealthSupply MMC', '012-555-1002', 'sales@healthsupply.az','İstiqlaliyyət küç. 12, Bakı'),
('PharmaPlus',       '012-555-1003', 'contact@pharmaplus.az','Neftçilər pr. 88, Bakı');

INSERT INTO categories (c_name, description) VALUES
('Antibiotiklər', 'Bakterial infeksiyaların müalicəsi üçün dərmanlar'),
('Ağrıkəsicilər', 'Ağrı və qızdırmanı azaldan dərmanlar'),
('Vitaminlər',    'Vitamin və mineral əlavələr'),
('Ürək-damar',    'Ürək və damar sistemini dəstəkləyən dərmanlar'),
('Mədə-bağırsaq', 'Həzm sistemi üçün dərmanlar');

INSERT INTO medications (m_name, category_id, supplier_id, unit_price, stock_quantity, min_stock_level, expiry_date) VALUES
('Augmentin 625mg',   1, 1, 12.50, 50,  10, '2026-08-01'),
('Amoxil 500mg',      1, 2, 6.80,  80,  15, '2026-06-15'),
('Paracetamol 500mg', 2, 1, 2.30,  120, 20, '2027-01-10'),
('Ibuprofen 400mg',   2, 3, 3.10,  90,  20, '2026-11-20'),
('Vitamin C 1000mg',  3, 2, 4.50,  60,  10, '2027-03-01'),
('Maqne B6',          3, 1, 7.20,  40,  10, '2026-09-30'),
('Enalapril 10mg',    4, 3, 5.60,  70,  15, '2026-12-31'),
('Omeprazol 20mg',    5, 2, 4.90,  55,  10, '2027-02-28');

INSERT INTO customers (customer_name, customer_surname, phone, email, address) VALUES
('Əli',   'Həsənov',    '050-111-2233', 'ali.hasanov@gmail.com', 'Yasamal r., Bakı'),
('Günel', 'Məmmədova',  '055-222-3344', 'gunel.m@mail.ru',       'Nəsimi r., Bakı'),
('Rauf',  'Əliyev',     '070-333-4455', 'rauf.aliyev@gmail.com', 'Xətai r., Bakı'),
('Leyla', 'İsmayılova', '077-444-5566', 'leyla.i@yahoo.com',     'Binəqədi r., Bakı'),
('Murad', 'Quliyev',    '051-555-6677', NULL,                    'Sabunçu r., Bakı');

INSERT INTO employees (employee_name, employee_surname, role, phone, email, hire_date, salary) VALUES
('Nigar',    'Rəsulova', 'Əczaçı',       '050-100-2001', 'nigar.r@pharmacy.az',    '2021-03-15', 1800.00),
('Tərlan',   'Babayev',  'Kassir',       '055-100-2002', 'terlan.b@pharmacy.az',   '2022-07-01', 900.00),
('Aytən',    'Nəcəfova', 'Əczaçı',       '070-100-2003', 'ayten.n@pharmacy.az',    '2020-11-10', 1750.00),
('Kənan',    'Hüseynov', 'Müdir',        '077-100-2004', 'kenan.h@pharmacy.az',    '2019-05-20', 2500.00),
('Sərvinaz', 'Orucova',  'Anbar işçisi', '051-100-2005', 'servinaz.o@pharmacy.az', '2023-01-08', 800.00);

INSERT INTO sales (customer_id, employee_id, total_amount) VALUES
(1,    1, 15.90),
(2,    2, 13.40),
(3,    1, 22.00),
(NULL, 3, 7.20),
(4,    2, 12.50),
(5,    1, 15.80);

INSERT INTO sale_items (sale_id, medication_id, quantity, unit_price) VALUES
(1, 3, 3, 2.30),
(1, 5, 2, 4.50),
(2, 4, 2, 3.10),
(2, 6, 1, 7.20),
(3, 1, 1, 12.50),
(3, 8, 1, 4.90),
(3, 3, 2, 2.30),
(4, 6, 1, 7.20),
(5, 1, 1, 12.50),
(6, 7, 2, 5.60),
(6, 3, 2, 2.30);

INSERT INTO prescriptions (sale_id, doctor_name) VALUES
(3, 'Dr. Əli Məmmədov'),
(5, 'Dr. Nərmin Əliyeva');