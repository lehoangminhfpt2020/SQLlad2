CREATE DATABASE BookLibrary 
GO

USE BookLibrary 
GO

CREATE TABLE Book 
(
	BookCode INT,
	BookTitle VARCHAR(100) NOT NULL,
	Author VARCHAR(50) NOT NULL,
	Edition INT, 
	BookPrice MONEY,
	Copies INT, 
	CONSTRAINT PK_BC PRIMARY KEY (Bookcode)
)
GO

CREATE TABLE Member 
(
	MemberCode INT,
	Name VARCHAR(50) NOT NULL,
	Address VARCHAR(100) NOT NULL,
	PhoneNumber INT,
	CONSTRAINT PK_MC PRIMARY KEY (MemberCode)
)
GO


CREATE TABLE IssueDetails 
(
	BookCode INT,
	MemberCode INT,
	CONSTRAINT FK_BC FOREIGN KEY (BookCode) REFERENCES Book (BookCode),
	CONSTRAINT FK_MC FOREIGN KEY (MemberCode) REFERENCES Member (MemberCode),
	IssueDate DATETIME,
	ReturnDate DATETIME
)
GO

--a. Xóa bỏ các Ràng buộc Khóa ngoại của bảng IssueDetails
ALTER TABLE IssueDetails DROP CONSTRAINT FK_BC
ALTER TABLE IssueDetails DROP CONSTRAINT FK_MC
GO

--b. Xóa bỏ Ràng buộc Khóa chính của bảng Member và Book
ALTER TABLE Book DROP CONSTRAINT PK_BC
ALTER TABLE Member DROP CONSTRAINT PK_MC
GO

--c. Thêm mới Ràng buộc Khóa chính cho bảng Member và Book
ALTER TABLE Book  ADD CONSTRAINT PK_BC1 PRIMARY KEY (Bookcode)
ALTER TABLE Member ADD CONSTRAINT PK_MC1 PRIMARY KEY (MemberCode)
GO

--d. Thêm mới các Ràng buộc Khóa ngoại cho bảng IssueDetails
ALTER TABLE IssueDetails ADD CONSTRAINT FK_BC1 FOREIGN KEY (BookCode) REFERENCES Book (BookCode)
ALTER TABLE IssueDetails ADD CONSTRAINT FK_MC1 FOREIGN KEY (MemberCode) REFERENCES Member (MemberCode)
GO

--e. Bổ sung thêm Ràng buộc giá bán sách > 0 và < 200
ALTER TABLE Book ADD CONSTRAINT PRICE CHECK (BookPrice BETWEEN 0 AND 200)
GO

--f. Bổ sung thêm Ràng buộc duy nhất cho PhoneNumber của bảng Member
ALTER TABLE Member ADD CONSTRAINT PhoneNumber UNIQUE (PhoneNumber)
GO

--g. Bổ sung thêm ràng buộc NOT NULL cho BookCode, MemberCode trong bảng IssueDetails
ALTER TABLE IssueDetails ALTER COLUMN BookCode INT NOT NULL
ALTER TABLE IssueDetails ALTER COLUMN MemberCode INT NOT NULL

--h. Tạo khóa chính gồm 2 cột BookCode, MemberCode cho bảng IssueDetails
ALTER TABLE IssueDetails ADD CONSTRAINT PK PRIMARY KEY (BookCode, MemberCode)

--i. Chèn dữ liệu hợp lý cho các bảng(Sử dụng SQL)
INSERT INTO Book (BookCode ,BookTitle ,Author ,Editition ,BookPrice ,Copies) VALUES (1,'Doremon', 'Fujiko.F.Fujio ',1,25,10)
INSERT INTO Member (MemberCode,Name,Address,PhoneNumber) VALUES (1,'Minh','HaNoi',123456)
INSERT INTO IssueDetails (BookCode,MemberCode,IssueDate,ReturnDate) VALUES (1,1,20201008,20201808)
