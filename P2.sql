create database edupro;
use edupro;

create table teachers (
    id int primary key auto_increment,
    full_name varchar(100) not null,
    salary decimal(12, 2) not null check (salary >= 0)
);

create table courses (
    id int primary key auto_increment,
    course_name varchar(150) not null,
    teacher_id int null,
    credits tinyint not null check (credits > 0),
    tuition_fee decimal(12, 2) not null check (tuition_fee >= 0),
    foreign key (teacher_id) references teachers(id) on delete set null
);

create table students (
    id int primary key auto_increment,
    full_name varchar(100) not null,
    date_of_birth date not null,
    gender enum('male', 'female', 'other') not null
);

create table enrollments (
    id int primary key auto_increment,
    student_id int not null,
    course_id int not null,
    date date not null,
    score decimal(4, 2) null check (score is null or (score >= 0 and score <= 10)),
    foreign key (student_id) references students(id) on delete cascade,
    foreign key (course_id) references courses(id) on delete cascade
);

insert into teachers (full_name, salary) values
('Nguyễn Văn An',     18000000),
('Trần Thị Bình',     20000000),
('Lê Minh IT',        22000000);

insert into courses (course_name, teacher_id, credits, tuition_fee) values
('Lập trình Python cơ bản',     3, 3, 2500000),
('Cơ sở dữ liệu IT',            3, 3, 2800000),
('Toán rời rạc',                1, 3, 2000000),
('Kỹ năng giao tiếp',           2, 2, 1500000),
('Marketing số',                2, 3, 3000000),
('Nhập môn trí tuệ nhân tạo',  null, 3, 3500000);

insert into students (full_name, date_of_birth, gender) values
('Phạm Thị Cúc',      '2003-04-12', 'female'),
('Hoàng Văn Dũng',    '2002-08-25', 'male'),
('Đặng Thị Hoa',      '2003-01-07', 'female'),
('Vũ Quốc Hùng',      '2002-11-30', 'male'),
('Bùi Thị Lan',       '2003-06-18', 'female'),
('Trịnh Văn Long',    '2001-03-22', 'male'),
('Ngô Thị Mai',       '2003-09-05', 'female'),
('Lý Văn Nam',        '2002-07-14', 'male'),
('Đỗ Thị Oanh',       '2003-12-01', 'female'),
('Cao Minh Tuấn',     '2001-05-19', 'male');

insert into enrollments (student_id, course_id, date, score) values
(1, 1, '2024-09-01', 8.5),
(1, 3, '2024-09-01', 7.0),
(2, 1, '2024-09-01', 9.0),
(2, 2, '2024-09-01', 6.5),
(3, 4, '2024-09-02', 8.0),
(4, 2, '2024-09-02', 7.5),
(4, 5, '2024-09-02', 8.0),
(5, 1, '2024-09-03', 6.0),
(5, 3, '2024-09-03', 7.5),
(6, 5, '2024-09-03', 9.5),
(7, 4, '2024-09-04', 8.5),
(8, 2, '2024-09-04', 7.0),
(9, 6, '2024-09-05', null),
(10, 6, '2024-09-05', null),
(3, 1, '2024-09-05', 8.0);

update teachers t
set t.salary = t.salary * 1.10
where t.id in (
    select distinct c.teacher_id
    from courses c
    where c.course_name like '%IT%'
      and c.teacher_id is not null
);

select c.id, c.course_name, t.full_name as teacher_name
from courses c
left join teachers t on c.teacher_id = t.id;
 
select id, full_name, date_of_birth
from students
where year(date_of_birth) = 2005;
 
select s.full_name, s.id as student_id, e.score
from enrollments e
join students s on e.student_id = s.id
join courses c on e.course_id = c.id
where c.course_name = 'Lập trình Web'
order by e.score desc;
 
select s.full_name as student_name, c.course_name, t.full_name as teacher_name
from enrollments e
join students s on e.student_id = s.id
join courses c on e.course_id = c.id
left join teachers t on c.teacher_id = t.id;