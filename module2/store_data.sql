insert into Users (second_name, first_name, b_year) values
('Smith', 'John', 1985),
('Doe', 'Jane', 1992),
('Brown', 'Charlie', 1978),
('Johnson', 'Emily', 2000),
('Taylor', 'Alex', 1995);

insert into UserInfo (user_id, email, address) values
(1, 'john.smith@example.com', '123 Main St'),
(2, 'jane.doe@example.com', '456 Oak St'),
(3, 'charlie.brown@example.com', '789 Pine St'),
(4, 'emily.johnson@example.com', '101 Maple St'),
(5, 'alex.taylor@example.com', '202 Birch St');

insert into Product (name, description, `count`, price) values
('Laptop', 'High performance laptop', 50, 1200.00),
('Smartphone', 'Latest model smartphone', 100, 800.00),
('Headphones', 'Noise-cancelling headphones', 200, 150.00),
('Monitor', '4K Ultra HD Monitor', 75, 450.00);

insert into Orders (user_id, product_id, `count`) values
(1, 1, 2),
(2, 2, 1),
(3, 3, 3),
(4, 4, 1);

insert into Comment (product_id, `text`) values
(1, 'Great laptop, very fast.'),
(2, 'This smartphone has an amazing camera.'),
(3, 'The headphones have excellent sound quality.'),
(4, 'The monitor is very clear and bright.');