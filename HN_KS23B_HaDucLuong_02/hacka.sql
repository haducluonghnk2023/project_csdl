create database room_management;
use room_management;
CREATE TABLE customer (
    customer_id CHAR(10) PRIMARY KEY,
    customer_full_name VARCHAR(150) NOT NULL,
    customer_email VARCHAR(255) UNIQUE,
    customer_address VARCHAR(255) NOT NULL
);
create table room(
	room_id varchar(10) primary key ,
    room_price decimal,
    room_status enum('Trống','Đã đặt'),
    room_area int 
);
create table booking (
	booking_id int primary key auto_increment,
    customer_id char(10) not null,
    room_id varchar(10) not null,
    check_in_date date not null,
    check_out_date date not null,
    total_amount decimal,
    foreign key (customer_id) references customer(customer_id),
    foreign key (room_id) references room(room_id)
);
create table payment(
	payment_id int primary key auto_increment,
    booking_id int not null,
    payment_method varchar(50) ,
    payment_date date not null,
    payment_amount decimal,
    foreign key (booking_id) references booking(booking_id)
);
-- phần 2
-- 2.2 Thêm cột room_type có kiểu dữ liệu là enum gồm các giá trị "single", "double", "suite" trong bảng Room.
alter table room
add column room_type enum('single','double','suite');
-- 2.3  Thêm cột số điện thoại khách hàng (customer_phone) trong bảng Customer có kiểu dữ liệu char(15), có rằng buộc not null và unique.
alter table customer 
add column customer_phone char(15) not null unique;
-- 2.4 Thêm ràng buộc cho cột total_amount trong bảng Booking phải có giá trị lớn hơn hoặc bằng 0.
alter table booking
add constraint total_amount check(total_amount >= 0);
-- phần 3
insert into customer(customer_id,customer_full_name,customer_email,customer_phone,customer_address) values 
('C001','Nguyen Anh Tu','tu.nguyen@example.com','0912345678','Hanoi, Vietnam'),
('C002','Tran Thi Mai','mai.tran@example.com','0923456789','Ho Chi Minh,Vietnam'),
('C003','Le Minh Hoang','hoang.le@example.com','0934567890','Danang, Vietnam'),
('C004','Pham Hoang Nam','nam.pham@example.com','0945678901','Hue, Vietnam'),
('C005','Vu Minh Thu','thu.vu@example.com','0956789012','Hai Phong, Vietnam'),
('C006','Nguyen Thi Lan','lan.nguyen@example.com','0967890123','Quang Ninh, Vietnam'),
('C007','Bui Minh Tuan','tuan.bui@example.com','0978901234','Bac Giang, Vietnam'),
('C008','Pham Quang Hieu','hieu.pham@example.com','0989012345','Quang Nam, Vietnam'),
('C009','Le Thi Lan','lan.le@example.com','0990123456','Da Lat, Vietnam'),
('C010','Nguyen Thi Mai','mai.nguyen@example.com','0901234567','Can Tho, Vietnam');
insert into room(room_id,room_type,room_price,room_status,room_area) values
('R001','Single','100.0','Trống',25),
('R002','Double','150.0','Đã đặt',40),
('R003','Suite','250.0','Trống',60),
('R004','Single','120.0','Đã đặt',30),
('R005','Double','160.0','Trống',35);
insert into booking(customer_id,room_id,check_in_date,check_out_date,total_amount) values
('C001','R001','2025-03-01','2025-03-05','400.0'),
('C002','R002','2025-03-02','2025-03-06','600.0'),
('C003','R003','2025-03-03','2025-03-07','1000.0'),
('C004','R004','2025-03-04','2025-03-08','480.0'),
('C005','R005','2025-03-05','2025-03-09','800.0'),
('C006','R001','2025-03-06','2025-03-10','400.0'),
('C007','R002','2025-03-07','2025-03-11','600.0'),
('C008','R003','2025-03-08','2025-03-12','1000.0'),
('C009','R004','2025-03-09','2025-03-13','480.0'),
('C010','R005','2025-03-10','2025-03-14','800.0');
insert into payment(booking_id,payment_method,payment_date,payment_amount) values 
(1,'Cash','2025-03-05','400.0'),
(2,'Credit Card','2025-03-06','600.0'),
(3,'Bank Transfer','2025-03-07','1000.0'),
(4,'Cash','2025-03-08','480.0'),
(5,'Credit Card','2025-03-09','800.0'),
(6,'Bank Transfer','2025-03-10','400.0'),
(7,'Cash','2025-03-11','600.0'),
(8,'Credit Card','2025-03-12','1000.0'),
(9,'Bank Transfer','2025-03-13','480.0'),
(10,'Cash','2025-03-14','800.0'),
(1,'Credit Card','2025-03-15','400.0'),
(2,'Bank Transfer','2025-03-06','600.0'),
(3,'Cash','2025-03-07','1000.0'),
(4,'Credit Card','2025-03-08','480.0'),
(5,'Bank Transfer','2025-03-09','800.0'),
(6,'Cash','2025-03-10','400.0'),
(7,'Credit Card','2025-03-11','600.0'),
(8,'Bank Transfer','2025-03-12','1000.0'),
(9,'Cash','2025-03-13','480.0'),
(10,'Credit Card','2025-03-14','800.0');
-- phần 4
-- 4.1 Lấy thông tin khách hàng gồm mã khách hàng, họ tên, email, số điện thoại và địa chỉ được sắp xếp theo họ tên khách hàng tăng dần.
select customer_id,customer_full_name,customer_email,customer_phone,customer_address
from customer
order by customer_full_name ;
-- 4.2 Lấy thông tin các phòng khách sạn gồm mã phòng, loại phòng, giá phòng và diện tích phòng, sắp xếp theo giá phòng giảm dần.
select room_id,room_type,room_price,room_area
from room
order by room_price desc;
-- 4.3 Lấy thông tin khách hàng và phòng khách sạn đã đặt, gồm mã khách hàng, họ tên khách hàng, mã phòng, ngày nhận phòng và ngày trả phòng.
select c.customer_id,c.customer_full_name,b.room_id,b.check_in_date,b.check_out_date
from customer c
join booking b on c.customer_id = b.customer_id;
-- 4.4	Lấy danh sách khách hàng và tổng tiền đã thanh toán khi đặt phòng, gồm mã khách hàng, 
--      họ tên khách hàng, phương thức thanh toán và số tiền thanh toán, sắp xếp theo số tiền thanh toán giảm dần
select c.customer_id,c.customer_full_name,p.payment_method,p.payment_amount
from customer c
join booking b on c.customer_id = b.customer_id
join payment p on b.booking_id = p.booking_id
order by p.payment_amount desc;
-- 4.5  Lấy thông tin khách hàng từ vị trí thứ 2 đến thứ 4 trong bảng Customer được sắp xếp theo tên khách hàng.
select customer_id,customer_full_name,customer_email,customer_address,customer_phone
from customer
order by customer_full_name
limit 3 offset 1;
-- 4.6 Lấy danh sách khách hàng đã đặt ít nhất 2 phòng và có tổng số tiền thanh toán trên 1000, 
--     gồm mã khách hàng, họ tên khách hàng và số lượng phòng đã đặt.
select c.customer_id,c.customer_full_name,count(b.room_id) as number_of_room_booked
from customer c
join booking b on c.customer_id = b.customer_id
join payment p on b.booking_id = p.booking_id
group by c.customer_id
having sum(p.payment_amount) > 1000 and count(b.room_id) >= 2;
-- 4.7 Lấy danh sách các phòng có tổng số tiền thanh toán dưới 1000 và có ít nhất 3 khách hàng đặt, 
--     gồm mã phòng, loại phòng, giá phòng và tổng số tiền thanh toán.
select r.room_id,r.room_type,r.room_price,sum(b.total_amount) as total_payment_amount
from room r
join booking b on r.room_id = b.room_id
join payment p on b.booking_id = p.booking_id
group by r.room_id
having sum(p.payment_amount) < 1000 and count(b.customer_id) >= 3;
-- 4.8  Lấy danh sách các khách hàng có tổng số tiền thanh toán lớn hơn 1000, 
--      gồm mã khách hàng, họ tên khách hàng, mã phòng, tổng số tiền thanh toán.
select c.customer_id,c.customer_full_name,b.room_id, sum(p.payment_amount) as total_payment
from customer c
join booking b on c.customer_id = b.customer_id
join payment p on b.booking_id = p.booking_id
group by c.customer_id,c.customer_full_name,b.room_id
having sum(p.payment_amount) > 1000;
-- 4.9 Lấy danh sách các phòng có số lượng khách hàng đặt nhiều nhất và ít nhất, gồm mã phòng, loại phòng và số lượng khách hàng đã đặt
with RoomBookingCounts as (
    select room_id, COUNT(customer_id) as customer_count
    from booking
    group by room_id
)
select r.room_id, r.room_type, r.room_price, rb.customer_count
from room r
join RoomBookingCounts rb on r.room_id = rb.room_id
where rb.customer_count = (select MAX(customer_count) from RoomBookingCounts)
   or rb.customer_count = (select MIN(customer_count) from RoomBookingCounts);
-- 4.10 . Lấy danh sách các khách hàng có tổng số tiền thanh toán của lần đặt phòng cao hơn số tiền thanh toán trung bình của tất cả các
select c.customer_id, c.customer_full_name, b.room_id, p.payment_amount
from customer c
join booking b on c.customer_id = b.customer_id
join payment p on b.booking_id = p.booking_id
where p.payment_amount > (
    select avg(p2.payment_amount)
    from payment p2
    join booking b2 on p2.booking_id = b2.booking_id
);
--         khách hàng cho cùng phòng, gồm mã khách hàng, họ tên khách hàng, mã phòng, tổng tiền thanh toán
-- phần 5
-- 5.1 Hãy tạo một view để lấy thông tin các phòng và khách hàng đã đặt, với điều kiện ngày nhận phòng nhỏ hơn ngày 2025-03-10.
--     Cần hiển thị các thông tin sau: Mã phòng, Loại phòng, Mã khách hàng, họ tên khách hàng
create view getRoomInformation as
select r.room_id,r.room_type,c.customer_id,c.customer_full_name
from room r
join booking b on r.room_id = b.room_id
join customer c on b.customer_id = c.customer_id
where check_in_date < '2025-03-10';
-- 5.2 Hãy tạo một view để lấy thông tin khách hàng và phòng đã đặt, với điều kiện diện tích phòng lớn hơn 30 m². 
--     Cần hiển thị các thông tin sau: Mã khách hàng, Họ tên khách hàng, Mã phòng, Diện tích phòng
create view customer_information as
select c.customer_id,c.customer_full_name,r.room_id,r.room_area
from customer c
join booking b on c.customer_id = b.customer_id
join room r on b.room_id = r.room_id
where r.room_area > 30;
-- phần 6
-- 6.1 Hãy tạo một trigger check_insert_booking để kiểm tra dữ liệu mối khi chèn vào bảng Booking. 
--  Kiểm tra nếu ngày đặt phòng mà sau ngày trả phòng thì thông báo lỗi với nội dung “Ngày đặt phòng không thể sau ngày trả phòng được !”
--  và hủy thao tác chèn dữ liệu vào bảng.
DELIMITER &&
create trigger check_insert_booking
before insert on booking
for each row
begin 
	if new.check_in_date > new.check_out_date then
		signal sqlstate '45000' set message_text = 'Ngày đặt phòng không thể sau ngày trả phòng được !';
    end if;
end &&
DELIMITER &&
alter table booking
drop foreign key booking_ibfk_1;
insert into booking(customer_id,room_id,check_in_date,check_out_date,total_amount) values
('C00100','R003','2025-03-16','2025-03-05','400.0'); -- lỗi 
-- 6.2 Hãy tạo một trigger có tên là update_room_status_on_booking để tự động cập nhật trạng thái phòng thành "Booked" 
-- khi một phòng được đặt (khi có bản ghi được INSERT vào bảng Booking).
DELIMITER &&
create trigger update_room_status_on_booking
after insert on booking
for each row
begin 
	update room
	set room_status = 'Đã đặt'
	where room_id = new.room_id;
end &&
DELIMITER ;
insert into booking(customer_id,room_id,check_in_date,check_out_date,total_amount) values
('C00100','R003','2025-03-16','2025-03-20','1000.0');
select * from room;
select * from booking;
-- phan 7
-- 7.1 Viết store procedure có tên add_customer để thêm mới một khách hàng với đầy đủ các thông tin cần thiết.
DELIMITER &&
create procedure add_customer (v_customer_id char(10),v_customer_full_name varchar(150),v_customer_email varchar(255),v_customer_address varchar(255),v_customer_phone char(15))
begin 
	insert into customer (customer_id,customer_full_name,customer_email,customer_address,customer_phone)
    values (v_customer_id,v_customer_full_name,v_customer_email,v_customer_address,v_customer_phone);
end &&
DELIMITER 
select * from customer;
call add_customer('C0011','Ha Duc Luong','ducluong@example.com','0392096054','PhuTho, Vietnam');	
/*
Hãy tạo một Stored Procedure  có tên là add_payment để thực hiện việc thêm một thanh toán mới cho một lần đặt phòng.
Procedure này nhận các tham số đầu vào:
p_booking_id: Mã đặt phòng (booking_id).
p_payment_method: Phương thức thanh toán (payment_method).
p_payment_amount: Số tiền thanh toán (payment_amount).
p_payment_date: Ngày thanh toán (payment_date).
*/
DELIMITER &&
create procedure add_payment(p_booking_id int,p_payment_method varchar(50),p_payment_date date,p_payment_amount decimal)
begin 
	if not exists (select 1 FROM Booking WHERE booking_id = p_booking_id) then
       signal sqlstate '45000' set message_text= 'Booking ID không tồn tại';
    end if;
    insert into Payment (booking_id, payment_method, payment_amount, payment_date) values 
    (p_booking_id, p_payment_method, p_payment_amount, p_payment_date);
    select 'Thanh toán được thêm thành công' as message;
end &&
DELIMITER 
call add_payment(8,'Cash','2025-03-16','800');
select * from payment;	