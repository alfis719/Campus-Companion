-- ============================================================
-- TEACHERS (Real data – Uttara University)
-- ============================================================
insert into public.teachers (name, designation, email, phone, office) values
('Prof. Farruque Mohammad Masud', 'Chairman (In-Charge), Associate Dean (SoB)', 'prof.farruquem.masud@uttarauniversity.edu.bd', '', 'Ext. 6801'),
('Dr. Md Kamrul Hasan', 'Associate Professor & Former Chairman', '', '', ''),
('Md. Hazrat Ali', 'Assistant Professor', '', '', ''),
('Sudipto Bain', 'Assistant Professor', '', '', ''),
('Tasnimul Arefin', 'Senior Lecturer / Assistant Professor', '', '', ''),
('Habibun Nahar', 'Lecturer', 'habibun.nahar@uttarauniversity.edu.bd', '', '');

-- ============================================================
-- STAFF (Real data)
-- ============================================================
insert into public.staff (name, role, email, phone) values
('Md. Rakibul Hasan', 'Section Officer', 'rakibul@uttara.ac.bd', '');

-- ============================================================
-- COURSES – Core (31 courses)
-- ============================================================
insert into public.courses (code, title, credits, category, prereq, description) values
('FDT0212101','Basic Drawing Skills',2,'core','None','Fundamentals of drawing for fashion design.'),
('FDT0212103','Textile Raw Material I',2,'core','None','Study of textile fibers and raw materials.'),
('FDT0212104','Import Export Management',2,'core','None','Import and export procedures in the apparel industry.'),
('FDT0212105','Historical Evolution of Textile and Costume',2,'core','None','History of textile and costume evolution.'),
('FDT0212201','RMG Marketing in Bangladesh and International Field',2,'core','None','Marketing strategies in the RMG sector.'),
('FDT0212202','Introduction to Fashion and Clothing Industry',2,'core','None','Overview of the fashion and clothing industry.'),
('FDT0212203','Garments Manufacturing Technology I',2,'core','None','Basic garment manufacturing processes.'),
('FDT0212204','Design',2,'core','None','Principles of design in fashion.'),
('FDT0212205','Basic Design and Concept',2,'core','None','Fundamental design concepts.'),
('FDT0212206','Management in Apparel Industry',2,'core','None','Management principles for apparel industry.'),
('FDT0212207','Essence of Design',2,'core','None','Core design theories and applications.'),
('FDT0212301','Basic Pattern Making-I',2,'core','None','Introduction to pattern making.'),
('FDT0212302','Garments Manufacturing Technology II',2,'core','FDT0212203','Advanced garment manufacturing.'),
('FDT0212303','Textile Technology-I',2,'core','None','Introduction to textile technology.'),
('FDT2012304','Fashion Illustration-I',2,'core','None','Fashion illustration techniques.'),
('FDT0212306','Production Maintenance and Management',2,'core','None','Maintenance and management in production.'),
('FDT0212307','CAD/CAM in the Garment Industry',3,'core','None','Computer-aided design in garments.'),
('FDT0212401','Basic Pattern Making-II',2,'core','FDT0212301','Advanced pattern making.'),
('FDT0212402','Garments Manufacturing Technology-III',2,'core','FDT0212302','Advanced garment manufacturing III.'),
('FDT0212403','Textile Technology-II',2,'core','FDT0212303','Advanced textile technology.'),
('FDT0212404','Textile Testing and Quality Control',2,'core','None','Textile testing methods and QC.'),
('FDT0212406','Fashion Marketing',2,'core','None','Marketing strategies for fashion.'),
('FDT0212408','Textile Raw Materials-II',2,'core','FDT0212103','Advanced study of textile materials.'),
('FDT0212501','Textile Technology III',2,'core','FDT0212403','Advanced textile technology III.'),
('FDT0212504','Knitwear Design',2,'core','None','Design principles for knitwear.'),
('FDT0212506','Quality Control Management',2,'core','None','Quality control in fashion production.'),
('FDM0212603','Fashion Retailing and Visual Merchandising-I',3,'core','None','Fashion retail and visual merchandising.'),
('FDM0212605','Garments Manufacturing Management',3,'core','None','Management of garment manufacturing.'),
('FDT0212703','Computer Aided Design (Photoshop & Illustrator)',2,'core','None','CAD using Photoshop and Illustrator.'),
('FDM0212802','Professional Practice and Development',3,'core','None','Professional development for fashion industry.'),
('FDM0212803','Shipping & Banking',3,'core','None','Shipping and banking procedures in apparel trade.');

-- ============================================================
-- COURSES – GED (16 courses)
-- ============================================================
insert into public.courses (code, title, credits, category, prereq, description) values
('GED0231106','English Communication Skill',3,'ged','None','English communication for fashion industry.'),
('GED0311509','Economics',3,'ged','None','Basic economic principles.'),
('GED0222107','Bangladesh Studies',3,'ged','None','History and culture of Bangladesh.'),
('GED0611102','Communication & IT in Fashion Industry',3,'ged','None','IT and communication in fashion.'),
('GED0541108','Basic Mathematics in Apparel Industry',3,'ged','None','Applied mathematics for apparel.'),
('GED0415503','Business Communication',3,'ged','None','Business communication skills.'),
('GED0531305','Basic Science',3,'ged','None','Fundamentals of science.'),
('GED0542505','Statistics',3,'ged','None','Statistical methods.'),
('GED0411208','Principles of Accounting',3,'ged','None','Accounting principles.'),
('GED0414405','Principles of Marketing',3,'ged','None','Marketing fundamentals.'),
('GED0215507','Fundamentals of Music',3,'ged','None','Basics of music.'),
('GED0521209','Environmental Science',3,'ged','None','Environmental science concepts.'),
('GED0413407','Organizational Behavior',3,'ged','None','Organizational behavior principles.'),
('GED0222308','History of Emergence in Bangladesh',3,'ged','None','History of Bangladesh emergence.'),
('GED0231409','(TBD)',3,'ged','None','To be determined.'),
('GED0413508','Human Resource Management',3,'ged','None','HRM principles.');

-- ============================================================
-- COURSES – Elective (18 courses)
-- ============================================================
insert into public.courses (code, title, credits, category, prereq, description) values
('FDT0212601','Advanced Pattern Making I',2,'elective','FDT0212401','Advanced pattern making I.'),
('FDT0212602','Fashion Illustration-II',2,'elective','FDT2012304','Advanced fashion illustration.'),
('FDT0212604','Woven Apparel Design I',2,'elective','None','Design of woven apparel.'),
('FDT0212606','Art of Jewelry Making',2,'elective','None','Jewelry design and making.'),
('FDT0212701','Woven Apparel Design II',2,'elective','FDT0212604','Advanced woven apparel design.'),
('FDT0212702','Advanced Pattern Making II',2,'elective','FDT0212601','Advanced pattern making II.'),
('FDT0212704','Advanced Pattern Making III',2,'elective','FDT0212702','Advanced pattern making III.'),
('FDT0212705','Fashion Portfolio',2,'elective','None','Creating a fashion portfolio.'),
('FDT0212801','Fashion Collection',2,'elective','None','Developing a fashion collection.'),
('FDT0212802','Advanced Pattern Making IV',2,'elective','FDT0212704','Advanced pattern making IV.'),
('FDM0212601','Supply Chain Management',2,'elective','None','Supply chain in fashion.'),
('FDM0212602','Management Information System',2,'elective','None','MIS for fashion industry.'),
('FDM0212604','Industrial Engineering',2,'elective','None','Industrial engineering principles.'),
('FDM0212606','Fully Fashion Knitwear Technology',2,'elective','None','Fully fashioned knitwear tech.'),
('FDM0212701','Research Methodology',2,'elective','None','Research methods for fashion.'),
('FDM0212702','Fashion Retailing and Visual Merchandising-II',2,'elective','FDM0212603','Advanced retail merchandising.'),
('FDM0212705','Sample Development and Management',2,'elective','None','Sample development processes.'),
('FDM0212801','Social Compliance and Labor Law',2,'elective','None','Social compliance and labor law.');

-- ============================================================
-- NOTICES
-- ============================================================
insert into public.notices (title, content, pinned, audience) values
('Welcome to Fall 2026', 'Classes begin from September 15, 2026. Please check your routine.', true, 'all'),
('Quiz 1 Schedule Announced', 'Quiz 1 for Pattern Making I will be held on Sept 25.', false, 'all');

-- ============================================================
-- EVENTS
-- ============================================================
insert into public.events (title, description, date, time, location) values
('Annual Fashion Show', 'Department annual fashion show featuring student collections.', '2026-12-10', '17:00', 'Main Auditorium'),
('Workshop on Draping', 'Hands-on draping workshop with guest designer.', '2026-10-05', '10:00', 'Studio 2');

-- ============================================================
-- BUSES
-- ============================================================
insert into public.buses (bus_number, route, arrival_time, departure_time, driver_name, driver_contact) values
('Bus41', 'Uttara → Mirpur → Campus', '07:30', '07:45', 'Abdul Karim', '01711-111111'),
('Bus42', 'Azimpur → Farmgate → Campus', '07:15', '07:30', 'Mizanur Rahman', '01711-222222');